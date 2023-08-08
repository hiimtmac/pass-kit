// PKPass+Extensions.swift
// Copyright (c) 2023 hiimtmac inc.

import Foundation
import PassCore

extension PKPass {
    func makeData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }
}
