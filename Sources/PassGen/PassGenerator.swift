// PassGenerator.swift
// Copyright (c) 2023 hiimtmac inc.

import Foundation
import PassCore
import ZIPFoundation

public struct PassGenerator {
    public let archive: Archive
    public let manifest = Manifest()

    public init() throws {
        guard let archive = Archive(accessMode: .create) else {
            throw Error.creatingArchive
        }
        self.archive = archive
    }

    public func insert(item data: Data, as path: String) throws {
        try archive.addFile(with: path, data: data)
        manifest.addHash(name: path, data: data)
    }

    public func add(pass: PKPass) throws {
        let data = try pass.makeData()
        try insert(item: data, as: "pass.json")
    }

    public func add(manifest data: Data) throws {
        try archive.addFile(with: "manifest.json", data: data)
    }

    public func add(signature data: Data) throws {
        try archive.addFile(with: "signature", data: data)
    }

    public func archiveData() throws -> Data {
        guard let data = archive.data else {
            throw Error.archiveData
        }
        return data
    }

    public enum Error: Swift.Error {
        case creatingArchive
        case archiveData
    }
}

extension PassGenerator.Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .creatingArchive: return "could not create in-memory archive"
        case .archiveData: return "could not get in-memory archive data"
        }
    }
}
