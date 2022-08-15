// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "LoggingPlayground",
    products: [
        .library(
            name: "LoggingPlayground",
            targets: ["LoggingPlayground"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", .upToNextMinor(from: "1.4.4")),
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
