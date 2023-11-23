// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftAsyncNetworking",
    platforms: [
        .iOS(.v14),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftAsyncNetworking",
            targets: ["SwiftAsyncNetworking"]),
    ],
    targets: [
        .target(
            name: "Logger",
            dependencies: []),
        .target(
            name: "NetworkError",
            dependencies: []),
        .target(
            name: "SwiftAsyncNetworking",
            dependencies: ["Logger", "NetworkError"]),
        .testTarget(
            name: "SwiftAsyncNetworkingTests",
            dependencies: ["SwiftAsyncNetworking"]),
    ]
)
