// PassGenerator.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation
import PassCore
import ZIPFoundation

public struct PassGenerator {
    let archive: Archive
    var manifest = Manifest()
    let signature = Signature()

    public init() throws {
        self.archive = try Archive(accessMode: .create)
    }

    mutating func insert(item data: Data, as path: String) throws {
        try archive.addFile(with: path, data: data)
        manifest.addHash(name: path, data: data)
    }

    public mutating func add(pass: Pass) throws {
        let data = try JSONEncoder.passKit.encode(pass)
        try insert(item: data, as: "pass.json")
    }

    public mutating func add(strings data: Data, for localization: String) throws {
        try insert(item: data, as: "\(localization).lproj/pass.strings")
    }

    public mutating func add(image data: Data, as type: Image, localization: String? = nil) throws {
        try insert(item: data, as: "\(localization.flatMap { "\($0).lproj/" } ?? "")\(type.name).png")
    }

    public mutating func add(manifest data: Data) throws {
        try archive.addFile(with: "manifest.json", data: data)
    }

    public mutating func add(signature data: Data) throws {
        try archive.addFile(with: "signature", data: data)
    }

    public func manifestData() throws -> Data {
        try manifest.makeData()
    }

    public func signatureData(manifest: Data, cert: Data, key: Data) throws -> Data {
        guard let wwdrUrl = Bundle.module.url(forResource: "wwdr", withExtension: "pem") else {
            throw Error.missingWWDR
        }

        let wwdr = try Data(contentsOf: wwdrUrl)

        return try signature.makeData(manifest: manifest, cert: cert, wwdr: wwdr, key: key)
    }

    public func archiveData() throws -> Data {
        guard let data = archive.data else {
            throw Error.archiveData
        }
        return data
    }

    public enum Error: Swift.Error {
        case archiveData
        case missingWWDR
    }

    public enum Image {
        case icon(Size)
        case logo(Size)
        case thumbnail(Size)
        case strip(Size)
        case background(Size)
        case footer(Size)

        var name: String {
            switch self {
            case let .icon(size): "icon\(size.postfix)"
            case let .logo(size): "logo\(size.postfix)"
            case let .thumbnail(size): "thumbnail\(size.postfix)"
            case let .strip(size): "strip\(size.postfix)"
            case let .background(size): "background\(size.postfix)"
            case let .footer(size): "footer\(size.postfix)"
            }
        }

        public enum Size {
            case x1
            case x2
            case x3

            var postfix: String {
                switch self {
                case .x1: ""
                case .x2: "@2x"
                case .x3: "@3x"
                }
            }
        }
    }
}

extension PassGenerator.Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .archiveData: "could not get in-memory archive data"
        case .missingWWDR: "could not find WWDR certificate in bundle"
        }
    }
}
