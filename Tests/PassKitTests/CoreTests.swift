// CoreTests.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation
import Testing
@testable import PassCore

@Suite
struct CoreTests {
    @Test
    func colorHexLong() throws {
        let data = Data(##""#4A90E2""##.utf8)
        let color = try JSONDecoder.passKit.decode(PassColor.self, from: data)
        #expect(color.r == 74)
        #expect(color.g == 144)
        #expect(color.b == 226)
    }

    @Test
    func colorHexShort() throws {
        let data = Data(##""#49E""##.utf8)
        let color = try JSONDecoder.passKit.decode(PassColor.self, from: data)
        #expect(color.r == 68)
        #expect(color.g == 153)
        #expect(color.b == 238)
    }

    @Test
    func colorRGBSpace() throws {
        let data = Data(#""rgb(74, 144, 226)""#.utf8)
        let color = try JSONDecoder.passKit.decode(PassColor.self, from: data)
        #expect(color.r == 74)
        #expect(color.g == 144)
        #expect(color.b == 226)
    }

    @Test
    func colorRGBTIght() throws {
        let data = Data(#""rgb(74,144,226)""#.utf8)
        let color = try JSONDecoder.passKit.decode(PassColor.self, from: data)
        #expect(color.r == 74)
        #expect(color.g == 144)
        #expect(color.b == 226)
    }
}
