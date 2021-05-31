// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pass-kit",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(name: "PassKit", targets: ["PassKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.3.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "0.4.0")),
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .upToNextMajor(from: "0.9.0")),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "1.1.0")
    ],
    targets: [
        .target(name: "PassKit", dependencies: [
            .product(name: "ShellOut", package: "ShellOut"),
            .product(name: "ZIPFoundation", package: "ZIPFoundation"),
            .product(name: "Crypto", package: "swift-crypto"),
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ]),
        .testTarget(name: "PassKitTests", dependencies: [
            .target(name: "PassKit")
        ]),
    ]
)
