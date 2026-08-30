// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    // https://github.com/swiftlang/swift-evolution/blob/main/proposals/0335-existential-any.md
    .enableUpcomingFeature("ExistentialAny"),

    // https://github.com/swiftlang/swift-evolution/blob/main/proposals/0409-access-level-on-imports.md
    .enableUpcomingFeature("InternalImportsByDefault"),

    // https://github.com/swiftlang/swift-evolution/blob/main/proposals/0444-member-import-visibility.md
    .enableUpcomingFeature("MemberImportVisibility"),
]

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
        .package(url: "https://github.com/adam-fowler/swift-zip-archive.git", .upToNextMajor(from: "0.8.1")),
        .package(url: "https://github.com/apple/swift-certificates.git", from: "1.19.0")
    ],
    targets: [
        .target(
            name: "PassCore",
            swiftSettings: swiftSettings
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
            ],
            swiftSettings: swiftSettings
        ),
        .target(
            name: "PassHelpers",
            dependencies: [
                .target(name: "PassCore"),
                .target(name: "PassGen")
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "PassKitTests",
            dependencies: [
                .target(name: "PassCore"),
                .target(name: "PassGen"),
                .product(name: "X509", package: "swift-certificates")
            ],
            resources: [.process("Resources")],
            swiftSettings: swiftSettings
        ),
    ]
)
