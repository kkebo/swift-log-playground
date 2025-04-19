// swift-tools-version:6.0

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
        .package(url: "https://github.com/apple/swift-log", from: "1.5.4")
    ],
    targets: [
        .target(
            name: "LoggingPlayground",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ],
            path: "Sources"
        )
    ]
)

// For development on iPadOS
#if canImport(AppleProductTypes) && os(iOS)
    import AppleProductTypes

    package.platforms = [.iOS(.v18)]
    package.products += [
        .iOSApplication(
            name: "Playground",
            targets: ["Playground"],
            supportedDeviceFamilies: [],
            supportedInterfaceOrientations: []
        )
    ]
    package.targets += [
        .executableTarget(
            name: "Playground",
            dependencies: [
                "LoggingPlayground",
                .product(name: "Logging", package: "swift-log"),
            ],
            path: "Playground"
        )
    ]
#endif
