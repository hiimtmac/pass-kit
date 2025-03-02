// ReaderTests.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation
import Testing
@testable import PassGen

@Suite
struct ReaderTests {
    let reader: PassReader

    init() throws {
        let url = Bundle.module.url(forResource: "Localized", withExtension: "pkpass")!
        let data = try Data(contentsOf: url)
        self.reader = try PassReader(data: data)
    }

    @Test
    func readLocalizations() throws {
        let localizations = reader.localizations()
        #expect(localizations.sorted() == ["en", "fr"])
    }

    @Test
    func testFullRead() throws {
        #expect(throws: Never.self) { try reader.pass() }

        #expect(throws: (any Error).self) { try reader.image(type: .icon(.x1)) }
        #expect(throws: Never.self) { try reader.image(type: .icon(.x2)) }
        #expect(throws: Never.self) { try reader.image(type: .icon(.x3)) }

        #expect(throws: (any Error).self) { try reader.image(type: .footer(.x1)) }
        #expect(throws: Never.self) { try reader.image(type: .footer(.x2)) }
        #expect(throws: Never.self) { try reader.image(type: .footer(.x3)) }

        #expect(throws: (any Error).self) { try reader.image(type: .logo(.x1), localization: "en") }
        #expect(throws: Never.self) { try reader.image(type: .logo(.x2), localization: "en") }
        #expect(throws: Never.self) { try reader.image(type: .logo(.x3), localization: "en") }
        #expect(throws: Never.self) { try reader.strings(localization: "en") }

        #expect(throws: (any Error).self) { try reader.image(type: .logo(.x1), localization: "fr") }
        #expect(throws: Never.self) { try reader.image(type: .logo(.x2), localization: "fr") }
        #expect(throws: Never.self) { try reader.image(type: .logo(.x3), localization: "fr") }
        #expect(throws: Never.self) { try reader.strings(localization: "fr") }
    }
}
