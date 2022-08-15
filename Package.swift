// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swutil",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "Swutil",
            targets: ["Swutil"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Swutil",
            dependencies: []),
        .testTarget(
            name: "SwutilTests",
            dependencies: ["Swutil"]),
    ]
)
