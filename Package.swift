// swift-tools-version: 5.10
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
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .upToNextMajor(from: "0.9.18")),
        .package(url: "https://github.com/apple/swift-certificates.git", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "PassCore",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableExperimentalFeature("StrictConcurrency")
//                .enableUpcomingFeature("StrictConcurrency") // Swift 6
            ]
        ),
        .target(
            name: "PassGen",
            dependencies: [
                .target(name: "PassCore"),
                .product(name: "ZIPFoundation", package: "ZIPFoundation"),
                .product(name: "X509", package: "swift-certificates")
            ],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableExperimentalFeature("StrictConcurrency")
//                .enableUpcomingFeature("StrictConcurrency") // Swift 6
            ]
        ),
        .target(
            name: "PassHelpers",
            dependencies: [
                .target(name: "PassCore")
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("StrictConcurrency"),
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(name: "PassKitTests", dependencies: [
            .target(name: "PassCore"),
            .target(name: "PassGen")
        ]),
    ]
)
