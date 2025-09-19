// Manifest.swift
// Copyright (c) 2025 hiimtmac inc.

import Crypto
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

struct Manifest {
    var hashes: [String: String] = [:]

    mutating func addHash(name: String, data: Data) {
        let hashData = Insecure.SHA1.hash(data: data)
        hashes[name] = hashData.map { String(format: "%02hhx", $0) }.joined()
    }

    func makeData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        return try encoder.encode(Intermediate(hashes: hashes))
    }

    private struct Intermediate: Encodable {
        let hashes: [String: String]

        func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(hashes)
        }
    }
}
