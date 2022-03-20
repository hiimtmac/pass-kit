// PrivateKeyCommand.swift
// Copyright © 2022 hiimtmac

import ArgumentParser
import Foundation
import ShellOut

/// Generates `key.pem` key from `.p12` file
public struct PrivateKeyCommand: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "keygen",
        abstract: "generates private signing key",
        discussion: "Take in .p12 bundle and exports private signing key for signature genration"
    )

    @Argument(completion: .file(extensions: ["p12"]), transform: fileTransform)
    var input: URL

    @Option(name: .shortAndLong, completion: .directory, transform: folderTransform)
    var output: URL?

    @Option(name: .long, help: "Certificate password")
    var passIn: String?

    @Option(name: .long, help: "Private key password")
    var passOut: String

    public init() {}

    public func run() throws {
        let name = self.input.deletingPathExtension().lastPathComponent
        let out = self.output ?? self.input.deletingLastPathComponent().appendingPathComponent("\(name).key")

        try shellOut(to: .generateKey(
            certificateIn: self.input,
            keyOut: out,
            passIn: self.passIn,
            passOut: self.passOut
        ))
    }
}
