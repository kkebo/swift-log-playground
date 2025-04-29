import Logging
import LoggingPlayground
import SwiftUI

let logger = Logger(label: "main")

@main
struct Playground: App {
    init() {
        // Use swift-log-playground only if running on Swift Playground or Xcode Previews
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            LoggingSystem.bootstrap { PlaygroundHandler(label: $0) }
        }
    }

    var body: some Scene {
        WindowGroup {
            Button("Test") {
                logger.error("Lorem ipsum")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .hoverEffect()
        }
    }
}
