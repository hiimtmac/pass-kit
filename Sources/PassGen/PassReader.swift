// PassReader.swift
// Copyright (c) 2025 hiimtmac inc.

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
import PassCore
import ZipArchive

extension DecodingError {
    fileprivate var message: String {
        switch self {
        case let .typeMismatch(any, context):
            let path = context.codingPath.map(\.stringValue).joined(separator: ".")
            return "type mismatch: \(any) at \(path) "
        case let .valueNotFound(any, context):
            let path = context.codingPath.map(\.stringValue).joined(separator: ".")
            return "value not found: \(any) at \(path) "
        case let .keyNotFound(codingKey, context):
            let path = context.codingPath.map(\.stringValue).joined(separator: ".")
            return "key not found: \(codingKey.stringValue) at \(path) "
        case let .dataCorrupted(context):
            let path = context.codingPath.map(\.stringValue).joined(separator: ".")
            return "data corruption at \(path)"
        @unknown default:
            return "unknown decoding error"
        }
    }
}

public struct PassReader {
    let archive: ZipArchiveReader<ZipMemoryStorage<[UInt8]>>

    public init(data: Data) throws {
        self.archive = try ZipArchiveReader(buffer: Array(data))
    }

    public func extract(file: String) throws -> Data? {
        let directory = try archive.readDirectory()
        guard
            let header = directory.first(where: { $0.filename == .init(file) })
        else { return nil }
        let buffer = try archive.readFile(header)
        return Data(buffer)
    }

    public func pass() throws -> Pass {
        guard let data = try extract(file: "pass.json") else {
            throw Error.missing("pass.json")
        }

        let pass: Pass
        do {
            pass = try JSONDecoder.passKit.decode(Pass.self, from: data)
        } catch let error as DecodingError {
            throw Error.pass(error.message)
        }

        return pass
    }

    public func personalization() throws -> Personalization {
        guard let data = try extract(file: "personalization.json") else {
            throw Error.missing("personalization.json")
        }

        let personalization: Personalization
        do {
            personalization = try JSONDecoder.passKit.decode(Personalization.self, from: data)
        } catch let error as DecodingError {
            throw Error.personalization(error.message)
        }

        return personalization
    }

    public func image(type: Image, localization: String? = nil) throws -> Data {
        let filename = "\(localization.flatMap { "\($0).lproj/" } ?? "")\(type.filename)"
        guard let data = try extract(file: filename) else {
            throw Error.missing(filename)
        }
        return data
    }

    public func strings(localization: String) throws -> Data {
        let filename = "\(localization).lproj/pass.strings"
        guard let data = try extract(file: filename) else {
            throw Error.missing(filename)
        }
        return data
    }

    public func localizations() throws -> [String] {
        try archive
            .readDirectory()
            .compactMap(\.filename.lastComponent)
            .filter { $0.extension == "lproj" }
            .map(\.stem)
            .compactMap { $0.wholeMatch(of: /(?<lang>[a-zA-Z\-]{2,})/) }
            .map(\.output.lang)
            .map(String.init)
    }

    public enum Error: Swift.Error {
        case missing(String)
        case pass(String)
        case personalization(String)
    }
}

extension PassReader.Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .missing(string): "Data/entry missing for \(string)"
        case let .pass(string): "Pass decoding error - \(string)"
        case let .personalization(string): "Personalization decoding error - \(string)"
        }
    }
}
