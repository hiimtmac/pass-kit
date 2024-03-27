// PassReader.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation
import PassCore
import ZIPFoundation

public struct PassReader {
    let archive: Archive

    public init(data: Data) throws {
        self.archive = try Archive(data: data, accessMode: .read)
    }

    public func extractPass() throws -> Pass {
        guard let entry = archive["pass.json"] else {
            throw ReaderError.entry("pass.json")
        }

        var pass: Pass?
        // assuming this file will never be > 16kb (defaultReadChunkSize)
        _ = try archive.extract(entry) {
            do {
                pass = try JSONDecoder.passKit.decode(Pass.self, from: $0)
            } catch {
                throw ReaderError.decoding(error.localizedDescription)
            }
        }

        guard let pass else {
            throw ReaderError.data("pass.json")
        }

        return pass
    }

    public func extract(
        image: Image.ImageType,
        localization: String? = nil
    ) throws -> (x1: Data?, x2: Data?, x3: Data?) {
        var data1 = Data()
        var data2 = Data()
        var data3 = Data()

        let prefix = localization.flatMap { "\($0).lproj/" } ?? ""
        let e1 = "\(prefix)\(Image(type: image, scale: .x1).filename)"
        let e2 = "\(prefix)\(Image(type: image, scale: .x2).filename)"
        let e3 = "\(prefix)\(Image(type: image, scale: .x3).filename)"

        if let x1 = archive[e1] {
            _ = try archive.extract(x1) { data1.append($0) }
        }

        if let x2 = archive[e2] {
            _ = try archive.extract(x2) { data2.append($0) }
        }

        if let x3 = archive[e3] {
            _ = try archive.extract(x3) { data3.append($0) }
        }

        return (
            x1: data1.isEmpty ? nil : data1,
            x2: data2.isEmpty ? nil : data2,
            x3: data3.isEmpty ? nil : data3
        )
    }

    enum ReaderError: Error {
        case entry(String)
        case data(String)
        case decoding(String)
    }
}

extension PassReader.ReaderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .entry(e): "could not find entry for \(e)"
        case let .data(d): "could not get data for \(d)"
        case let .decoding(d): "could not decode pass: \(d)"
        }
    }
}
