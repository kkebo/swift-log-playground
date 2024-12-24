# LoggingPlayground

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fkkebo%2Fswift-log-playground%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/kkebo/swift-log-playground)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fkkebo%2Fswift-log-playground%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/kkebo/swift-log-playground)
[![License](https://img.shields.io/github/license/kkebo/swift-log-playground.svg)](LICENSE)

This Swift package is a logging backend for [SwiftLog](https://github.com/apple/swift-log). It is usable on Swift Playgrounds.

## Adding the dependency

You need to declare your dependency in your Package.swift:

```swift
.package(url: "https://github.com/kkebo/swift-log-playground", from: "0.2.0"),
```

and to your application/library target, add "LoggingPlayground" to your dependencies, e.g. like this:

```swift
.target(
    name: "YourLibrary",
    dependencies: [
        .product(name: "LoggingPlayground", package: "swift-log-playground")
    ]
),
```

## Example (Playground Book or Xcode Playground)

```swift
import Logging
import LoggingPlayground

let logger = Logger(label: "main")

LoggingSystem.bootstrap { PlaygroundHandler(label: $0) }

logger.debug("The program started.")
```

## Example (App Project)

```swift
import Logging
import LoggingPlayground
import SwiftUI

let logger = Logger(label: "main")

@main
struct MyApp: App {
    init() {
        LoggingSystem.bootstrap { PlaygroundHandler(label: $0) }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```
