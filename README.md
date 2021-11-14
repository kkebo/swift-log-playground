# LoggingPlayground

This Swift package is a logging backend for [SwiftLog](https://github.com/apple/swift-log). It can be usable on Swift Playgrounds.

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

## Example

```swift
import Logging
import LoggingPlayground

let logger = Logger(label: "main")

LoggingSystem.bootstrap(PlaygroundHandler.init)

logger.debug("The program started.")
```