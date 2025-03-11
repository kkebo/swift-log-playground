import Foundation
import Logging

public struct PlaygroundHandler: Sendable {
    private let label: String
    private var prettyMetadata: String?
    public var metadata = Logger.Metadata() {
        didSet {
            self.prettyMetadata = self.prettify(self.metadata)
        }
    }
    public var logLevel = Logger.Level.info

    public init(label: String) {
        self.label = label
    }

    private func prettify(_ metadata: Logger.Metadata) -> String? {
        guard !metadata.isEmpty else { return nil }
        return metadata.lazy
            .sorted(by: { $0.key < $1.key })
            .map { "\($0)=\($1)" }
            .joined(separator: " ")
    }

    private func timestamp() -> String {
        var buffer = [Int8](repeating: 0, count: 255)
        #if os(Windows)
        var timestamp = __time64_t()
        _ = _time64(&timestamp)

        var localTime = tm()
        _ = _localtime64_s(&localTime, &timestamp)

        _ = strftime(&buffer, buffer.count, "%Y-%m-%dT%H:%M:%S%z", &localTime)
        #else
        var timestamp = time(nil)
        guard let localTime = localtime(&timestamp) else {
            return "<unknown>"
        }
        strftime(&buffer, buffer.count, "%Y-%m-%dT%H:%M:%S%z", localTime)
        #endif
        return buffer.withUnsafeBufferPointer {
            $0.withMemoryRebound(to: CChar.self) {
                // swift-format-ignore: NeverForceUnwrap
                String(cString: $0.baseAddress!)
            }
        }
    }
}

extension PlaygroundHandler: LogHandler {
    public func log(
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        let prettyMetadata: String?
        if let metadata = metadata, !metadata.isEmpty {
            prettyMetadata = self.prettify(
                self.metadata.merging(
                    metadata,
                    uniquingKeysWith: { _, new in new }
                )
            )
        } else {
            prettyMetadata = self.prettyMetadata
        }
        print(
            "\(self.timestamp()) [\(self.label)] \(level):\(prettyMetadata.map { " \($0)" } ?? "") \(message)"
        )
    }

    public subscript(
        metadataKey metadataKey: String
    ) -> Logger.Metadata.Value? {
        get { self.metadata[metadataKey] }
        set { self.metadata[metadataKey] = newValue }
    }
}
