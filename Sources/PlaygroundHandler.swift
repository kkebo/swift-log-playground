import Logging

#if canImport(Darwin)
    import Darwin
#elseif os(Windows)
    import CRT
#elseif canImport(Glibc)
    import Glibc
#elseif canImport(Android)
    import Android
#elseif canImport(Musl)
    import Musl
#elseif canImport(WASILibc)
    import WASILibc
#else
    #error("Unsupported runtime")
#endif

/// A log handler for Swift Playground.
public struct PlaygroundHandler: Sendable {
    private let label: String
    private var prettyMetadata: String?
    /// Get or set the entire metadata storage as a dictionary.
    ///
    /// - note: `LogHandler`s must treat logging metadata as a value type. This means that the change in metadata must
    ///         only affect this very `LogHandler`.
    public var metadata = Logger.Metadata() {
        didSet {
            self.prettyMetadata = self.prettify(self.metadata)
        }
    }
    /// Get or set the configured log level.
    ///
    /// - note: `LogHandler`s must treat the log level as a value type. This means that the change in metadata must
    ///         only affect this very `LogHandler`. It is acceptable to provide some form of global log level override
    ///         that means a change in log level on a particular `LogHandler` might not be reflected in any
    ///        `LogHandler`.
    public var logLevel = Logger.Level.info

    /// An initializer.
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
    /// Output a log to stdout.
    ///
    /// This method is called when a `LogHandler` must emit a log message. There is no need for the `LogHandler` to
    /// check if the `level` is above or below the configured `logLevel` as `Logger` already performed this check and
    /// determined that a message should be logged.
    ///
    /// - parameters:
    ///     - level: The log level the message was logged at.
    ///     - message: The message to log. To obtain a `String` representation call `message.description`.
    ///     - metadata: The metadata associated to this log message.
    ///     - source: The source where the log message originated, for example the logging module.
    ///     - file: The file the log message was emitted from.
    ///     - function: The function the log line was emitted from.
    ///     - line: The line the log message was emitted from.
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

    /// Add, remove, or change the logging metadata.
    ///
    /// - note: `LogHandler`s must treat logging metadata as a value type. This means that the change in metadata must
    ///         only affect this very `LogHandler`.
    ///
    /// - parameters:
    ///    - metadataKey: The key for the metadata item
    public subscript(
        metadataKey metadataKey: String
    ) -> Logger.Metadata.Value? {
        get { self.metadata[metadataKey] }
        set { self.metadata[metadataKey] = newValue }
    }
}
