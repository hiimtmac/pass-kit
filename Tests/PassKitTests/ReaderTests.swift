// ReaderTests.swift
// Copyright (c) 2024 hiimtmac inc.

import XCTest
@testable import PassGen

final class ReaderTests: XCTestCase {
    var reader: PassReader!

    override func setUp() async throws {
        try await super.setUp()

        let url = Bundle.module.url(forResource: "Localized", withExtension: "pkpass")!
        let data = try Data(contentsOf: url)
        reader = try PassReader(data: data)
    }

    func testReadLocalizations() throws {
        let localizations = reader.localizations()
        XCTAssertEqual(localizations.sorted(), ["en", "fr"])
    }

    func testFullRead() throws {
        XCTAssertNoThrow(try reader.pass())

        XCTAssertThrowsError(try reader.image(type: .icon(.x1)))
        XCTAssertNoThrow(try reader.image(type: .icon(.x2)))
        XCTAssertNoThrow(try reader.image(type: .icon(.x3)))

        XCTAssertThrowsError(try reader.image(type: .footer(.x1)))
        XCTAssertNoThrow(try reader.image(type: .footer(.x2)))
        XCTAssertNoThrow(try reader.image(type: .footer(.x3)))

        XCTAssertThrowsError(try reader.image(type: .logo(.x1), localization: "en"))
        XCTAssertNoThrow(try reader.image(type: .logo(.x2), localization: "en"))
        XCTAssertNoThrow(try reader.image(type: .logo(.x3), localization: "en"))
        XCTAssertNoThrow(try reader.strings(localization: "en"))

        XCTAssertThrowsError(try reader.image(type: .logo(.x1), localization: "fr"))
        XCTAssertNoThrow(try reader.image(type: .logo(.x2), localization: "fr"))
        XCTAssertNoThrow(try reader.image(type: .logo(.x3), localization: "fr"))
        XCTAssertNoThrow(try reader.strings(localization: "fr"))
    }
}
