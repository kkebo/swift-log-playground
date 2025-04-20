import Logging
import LoggingPlayground
import SwiftUI

let logger = Logger(label: "main")

@main
struct Playground: App {
    init() {
        LoggingSystem.bootstrap { PlaygroundHandler(label: $0) }
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
