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

    // TODO: need to use data before extracting another
    public func extract(
        path: String,
        bufferSize: Int = defaultReadChunkSize
    ) throws -> Data {
        guard let entry = archive[path] else {
            throw ReaderError.entry(path)
        }

        var data: Data?
        _ = try archive.extract(entry, bufferSize: bufferSize) { data = $0 }

        guard let data else {
            throw ReaderError.data(path)
        }

        return data
    }

    public func optionallyExtract(
        path: String,
        bufferSize: Int = defaultReadChunkSize
    ) throws -> Data? {
        guard let entry = archive[path] else {
            return nil
        }

        var data: Data?
        _ = try archive.extract(entry, bufferSize: bufferSize) { data = $0 }

        return data
    }

    enum ReaderError: Error {
        case entry(String)
        case data(String)
    }
}

extension PassReader.ReaderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .entry(e): "could not find entry for \(e)"
        case let .data(d): "could not get data for \(d)"
        }
    }
}
