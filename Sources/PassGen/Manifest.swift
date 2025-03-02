// Manifest.swift
// Copyright (c) 2025 hiimtmac inc.

import Crypto
import Foundation

struct Manifest {
    var hashes: [String: String] = [:]

    mutating func addHash(name: String, data: Data) {
        let hashData = Insecure.SHA1.hash(data: data)
        hashes[name] = hashData.map { String(format: "%02hhx", $0) }.joined()
    }

    func makeData() throws -> Data {
        try JSONSerialization.data(
            withJSONObject: hashes,
            options: [.prettyPrinted, .sortedKeys]
        )
    }
}
