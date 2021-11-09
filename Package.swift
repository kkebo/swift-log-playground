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
    dependencies: [],
    targets: [
        .target(
            name: "LoggingPlayground",
            dependencies: []
        ),
    ]
)
