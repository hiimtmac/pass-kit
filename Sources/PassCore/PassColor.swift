// PassColor.swift
// Copyright (c) 2024 hiimtmac inc.

public struct PassColor: Codable, Equatable, Hashable, Sendable {
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

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.string)
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        
        let rgb = /rgb\((?<r>\d{1,3}),\s?(?<g>\d{1,3}),\s?(?<b>\d{1,3})\)/
        let shortHex = /#(?<r>[a-fA-F\d])(?<g>[a-fA-F\d])(?<b>[a-fA-F\d])\b/
        let longHex = /#(?<r>[a-fA-F\d]{2})(?<g>[a-fA-F\d]{2})(?<b>[a-fA-F\d]{2})\b/
        
        if let rgbMatch = string.wholeMatch(of: rgb) {
            guard
                let r = Int(rgbMatch.output.r),
                let g = Int(rgbMatch.output.g),
                let b = Int(rgbMatch.output.b)
            else {
                throw DecodingError.dataCorrupted(.init(
                    codingPath: decoder.codingPath,
                    debugDescription: "rgb values must be 1-3 digit integers"
                ))
            }
            
            self.r = r
            self.g = g
            self.b = b
        } else if let shortHexMatch = string.wholeMatch(of: shortHex) {
            guard
                let r = Int(shortHexMatch.output.r, radix: 16),
                let g = Int(shortHexMatch.output.g, radix: 16),
                let b = Int(shortHexMatch.output.b, radix: 16)
            else {
                throw DecodingError.dataCorrupted(.init(
                    codingPath: decoder.codingPath,
                    debugDescription: "rgb values must be #RGB: a-fA-F0-9"
                ))
            }
            
            self.r = (r * 17) & 0xFF
            self.g = (g * 17) & 0xFF
            self.b = (b * 17) & 0xFF
        } else if let longHexMatch = string.wholeMatch(of: longHex) {
            guard
                let r = Int(longHexMatch.output.r, radix: 16),
                let g = Int(longHexMatch.output.g, radix: 16),
                let b = Int(longHexMatch.output.b, radix: 16)
            else {
                throw DecodingError.dataCorrupted(.init(
                    codingPath: decoder.codingPath,
                    debugDescription: "rgb values must be #RRGGBB: a-fA-F0-9"
                ))
            }
            
            self.r = r & 0xFF
            self.g = g & 0xFF
            self.b = b & 0xFF
        } else {
            throw DecodingError.dataCorrupted(.init(
                codingPath: decoder.codingPath,
                debugDescription: "Unhandled format: `\(string)`. (Should be `rgb(r,g,b)`/`#RGB`/`#RRGGBB`)"
            ))
        }
    }
}
