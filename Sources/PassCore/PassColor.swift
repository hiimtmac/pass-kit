// PassColor.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation

public struct PassColor: Codable, Equatable, Hashable {
    public let r: Int
    public let g: Int
    public let b: Int

    var string: String {
        "rgb(\(self.r),\(self.g),\(self.b))"
    }

    public init(r: Int, g: Int, b: Int) {
        self.r = r
        self.g = g
        self.b = b
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.string)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        
        let regex = /rgb\((?<r>\d{1,3}),\s?(?<g>\d{1,3}),\s?(?<b>\d{1,3})\)/
        guard let match = string.wholeMatch(of: regex) else {
            throw DecodingError.dataCorrupted(.init(
                codingPath: decoder.codingPath,
                debugDescription: "Unhandled rgb format: `\(string)`. Should be `rgb(r,g,b)` or `rgb(r, g, b)`"
            ))
        }
        
        guard
            let r = Int(match.output.r),
            let g = Int(match.output.g),
            let b = Int(match.output.b)
        else {
            throw DecodingError.dataCorrupted(.init(
                codingPath: decoder.codingPath,
                debugDescription: "rgb values must be 1-3 digit integers"
            ))
        }
        
        self.r = r
        self.g = g
        self.b = b
    }
}
