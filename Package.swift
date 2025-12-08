// swift-tools-version: 6.0

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
        .package(url: "https://github.com/apple/swift-log", "1.5.4"..."1.7.0")
    ],
    targets: [
        .target(
            name: "LoggingPlayground",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ]
        )
    ]
)
