// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PassKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "PassCore", targets: ["PassCore"]),
        .library(name: "PassGen", targets: ["PassGen"]),
        .library(name: "PassHelpers", targets: ["PassHelpers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/adam-fowler/swift-zip-archive.git", .upToNextMajor(from: "0.6.3")),
        .package(url: "https://github.com/apple/swift-certificates.git", from: "1.8.0")
    ],
    targets: [
        .target(
            name: "PassCore"
        ),
        .target(
            name: "PassGen",
            dependencies: [
                .target(name: "PassCore"),
                .product(name: "ZipArchive", package: "swift-zip-archive"),
                .product(name: "X509", package: "swift-certificates")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "PassHelpers",
            dependencies: [
                .target(name: "PassCore"),
                .target(name: "PassGen")
            ]
        ),
        .testTarget(
            name: "PassKitTests",
            dependencies: [
                .target(name: "PassCore"),
                .target(name: "PassGen"),
                .product(name: "X509", package: "swift-certificates")
            ],
            resources: [.process("Resources")]
        ),
    ]
)
