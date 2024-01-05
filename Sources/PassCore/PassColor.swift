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
        let trimmed = String(string.dropFirst(4).dropLast())
        let components = trimmed.components(separatedBy: ",")
        self.r = Int(components[0])!
        self.g = Int(components[1])!
        self.b = Int(components[2])!
    }
}
