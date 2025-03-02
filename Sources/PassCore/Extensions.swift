// Extensions.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation

extension JSONEncoder {
    public static let passKit: JSONEncoder = {
        let e = JSONEncoder()
        e.dateEncodingStrategy = .iso8601
        return e
    }()
}

extension JSONDecoder {
    public static let passKit: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }()
}
