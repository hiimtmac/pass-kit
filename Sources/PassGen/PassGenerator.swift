// PassGenerator.swift
// Copyright (c) 2025 hiimtmac inc.

import _CryptoExtras
// TODO: `Bundle` is not available in FoundationEssentials
// #if canImport(FoundationEssentials)
// import FoundationEssentials
// #else
import Foundation
// #endif
import PassCore
import X509
import ZipArchive

public struct PassGenerator {
    let archive: ZipArchiveWriter<ZipMemoryStorage<[UInt8]>>
    var manifest = Manifest()

    public init() throws {
        self.archive = ZipArchiveWriter()
    }

    mutating func insert(item data: Data, as path: String) throws {
        try archive.writeFile(filename: path, contents: Array(data))
        manifest.addHash(name: path, data: data)
    }

    public mutating func add(pass: Pass) throws {
        let data = try JSONEncoder.passKit.encode(pass)
        try insert(item: data, as: "pass.json")
    }

    public mutating func add(personalization: Personalization) throws {
        let data = try JSONEncoder.passKit.encode(personalization)
        try insert(item: data, as: "personalization.json")
    }

    public mutating func add(strings data: Data, for localization: String) throws {
        try insert(item: data, as: "\(localization).lproj/pass.strings")
    }

    public mutating func add(image data: Data, as type: Image, localization: String? = nil) throws {
        try insert(item: data, as: "\(localization.flatMap { "\($0).lproj/" } ?? "")\(type.filename)")
    }

    public mutating func add(manifest data: Data) throws {
        try archive.writeFile(filename: "manifest.json", contents: Array(data))
    }

    public mutating func add(signature data: Data) throws {
        try archive.writeFile(filename: "signature", contents: Array(data))
    }

    public func manifestData() throws -> Data {
        try manifest.makeData()
    }
    
    public func signatureData(manifest: Data, cert: Data, key: Data, representation: Representation = .pem) throws -> Data {
        guard let wwdrUrl = Bundle.module.url(forResource: "AppleWWDRCAG4", withExtension: "cer") else {
            throw Error.missingWWDR
        }

        let wwdr = try Certificate(derEncoded: Array(Data(contentsOf: wwdrUrl)))
        
        let cert: Certificate = switch representation {
        case .pem: try Certificate(pemEncoded: String(decoding: cert, as: UTF8.self))
        case .der: try Certificate(derEncoded: Array(cert))
        }
        
        let key: _RSA.Signing.PrivateKey = switch representation {
        case .pem: try _RSA.Signing.PrivateKey(pemRepresentation: String(decoding: key, as: UTF8.self))
        case .der: try _RSA.Signing.PrivateKey(derRepresentation: key)
        }
        
        return try Signature.makeData(manifest: manifest, cert: cert, wwdr: wwdr, key: key)
    }
    
    public enum Representation {
        case pem
        case der
    }

    public func archiveData() throws -> Data {
        let buffer = try archive.finalizeBuffer()
        return Data(buffer)
    }

    public enum Error: Swift.Error {
        case missingWWDR
    }
}

extension PassGenerator.Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .missingWWDR: "could not find WWDR certificate in bundle"
        }
    }
}
