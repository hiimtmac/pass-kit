// swift-tools-version: 5.8
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
    ],
    dependencies: [
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .upToNextMajor(from: "0.9.16")),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "2.6.0"),
        .package(url: "https://github.com/apple/swift-certificates.git", from: "1.0.0-beta.1")
    ],
    targets: [
        .target(
            name: "PassCore",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals")
            ]
        ),
        .target(
            name: "PassGen",
            dependencies: [
                .target(name: "PassCore"),
                .product(name: "ZIPFoundation", package: "ZIPFoundation"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "X509", package: "swift-certificates")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(name: "PassKitTests", dependencies: [
            .target(name: "PassCore"),
            .target(name: "PassGen")
        ]),
    ]
)
