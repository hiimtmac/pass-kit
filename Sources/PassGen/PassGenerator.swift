// PassGenerator.swift
// Copyright (c) 2023 hiimtmac inc.

import Foundation
import PassCore
import ZIPFoundation

public struct PassGenerator {
    let archive: Archive
    let manifest = Manifest()

    public init() throws {
        guard let archive = Archive(accessMode: .create) else {
            throw Error.creatingArchive
        }
        self.archive = archive
    }

    func insert(item data: Data, as path: String) throws {
        try archive.addFile(with: path, data: data)
        manifest.addHash(name: path, data: data)
    }
    
    public func add(pass: PKPass) throws {
        let data = try pass.makeData()
        try insert(item: data, as: "pass.json")
    }
    
    public func add(strings data: Data, for localization: String) throws {
        try insert(item: data, as: "\(localization).lproj/pass.strings")
    }
    
    public func add(image data: Data, as type: Image, localization: String? = nil) throws {
        try insert(item: data, as: "\(localization.flatMap { "\($0).lproj/" } ?? "")\(type.name).png")
    }

    public func add(manifest data: Data) throws {
        try archive.addFile(with: "manifest.json", data: data)
    }

    public func add(signature data: Data) throws {
        try archive.addFile(with: "signature", data: data)
    }
    
    public func manifestData() throws -> Data {
        try manifest.makeData()
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
    
    public enum Image {
        case icon(Size)
        case logo(Size)
        case thumbnail(Size)
        case strip(Size)
        case background(Size)
        case footer(Size)
        
        var name: String {
            switch self {
            case let .icon(size): return "icon\(size.postfix)"
            case let .logo(size): return "logo\(size.postfix)"
            case let .thumbnail(size): return "thumbnail\(size.postfix)"
            case let .strip(size): return "strip\(size.postfix)"
            case let .background(size): return "background\(size.postfix)"
            case let .footer(size): return "footer\(size.postfix)"
            }
        }
        
        public enum Size {
            case x1
            case x2
            case x3
            
            var postfix: String {
                switch self {
                case .x1: return ""
                case .x2: return "@2x"
                case .x3: return "@3x"
                }
            }
        }
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