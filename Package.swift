// swift-tools-version:5.9

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
        .package(url: "https://github.com/apple/swift-log", from: "1.5.4"),
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
