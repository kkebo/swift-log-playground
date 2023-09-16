// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "swift-log-playground",
    products: [
        .library(
            name: "LoggingPlayground",
            targets: ["LoggingPlayground"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", .upToNextMinor(from: "1.5.3")),
    ],
    targets: [
        .target(
            name: "LoggingPlayground",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ]
        ),
    ]
)
