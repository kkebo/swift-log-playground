# LoggingPlayground

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fkkk669%2Fswift-log-playground%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/kkk669/swift-log-playground)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fkkk669%2Fswift-log-playground%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/kkk669/swift-log-playground)
[![License](https://img.shields.io/github/license/kkk669/swift-log-playground.svg)](LICENSE)

This Swift package is a logging backend for [SwiftLog](https://github.com/apple/swift-log). It is usable on Swift Playgrounds.

## Adding the dependency

You need to declare your dependency in your Package.swift:

```swift
.package(url: "https://github.com/kkk669/swift-log-playground", from: "0.1.0"),
```

and to your application/library target, add "LoggingPlayground" to your dependencies, e.g. like this:

```swift
.target(name: "YourLibrary", dependencies: [
    .product(name: "LoggingPlayground", package: "swift-log-playground")
],
```

## Example (Playground Book or Xcode Playground)

```swift
import Logging
import LoggingPlayground

let logger = Logger(label: "main")

LoggingSystem.bootstrap(PlaygroundHandler.init)

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
        LoggingSystem.bootstrap(PlaygroundHandler.init)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```
