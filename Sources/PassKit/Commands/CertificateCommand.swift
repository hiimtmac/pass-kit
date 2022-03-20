// CertificateCommand.swift
// Copyright © 2022 hiimtmac

import ArgumentParser
import Foundation
import ShellOut

/// Generates `cert.pem` certificate from `.p12` file
public struct CertificateCommand: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "certgen",
        abstract: "generates signing certificate",
        discussion: "Take in .p12 bundle and exports certificate for signature genration"
    )

    @Argument(completion: .file(extensions: ["p12"]), transform: fileTransform)
    var input: URL

    @Option(name: .shortAndLong, completion: .directory, transform: folderTransform)
    var output: URL?

    @Option(name: .shortAndLong, help: "Certificate password")
    var password: String?

    public init() {}

    public func run() throws {
        let name = self.input.deletingPathExtension().lastPathComponent
        let out = self.output ?? self.input.deletingLastPathComponent().appendingPathComponent("\(name).cer")

        try shellOut(to: .generateCertificate(
            certificateIn: self.input,
            certificateOut: out,
            passIn: self.password
        ))
    }
}
