// PassReader.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation
import ZIPFoundation

public struct PassReader {
    let archive: Archive

    public init(data: Data) throws {
        self.archive = try Archive(data: data, accessMode: .read)
    }

    public func extract(file: String) throws -> Data? {
        guard let entry = archive[file] else { return nil }

        var data = Data()

        _ = try archive.extract(entry) { data.append($0) }

        return data.isEmpty ? nil : data
    }
}
