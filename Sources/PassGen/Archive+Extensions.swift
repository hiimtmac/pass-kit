// Archive+Extensions.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation
import ZIPFoundation

extension Archive {
    func addFile(with path: String, data: Data) throws {
        try addEntry(with: path, type: .file, uncompressedSize: Int64(data.count)) { position, size in
            data.subdata(in: Int(position) ..< Int(position) + size)
        }
    }
}
