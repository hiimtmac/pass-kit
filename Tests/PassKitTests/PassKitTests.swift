// PassKitTests.swift
// Copyright (c) 2023 hiimtmac inc.

import PassCore
import XCTest
@testable import PassGen

final class PassKitTests: XCTestCase {
    func testGenerateManifest() throws {
        let manifest = Manifest()
        manifest.addHash(name: "hi", data: Data("hi".utf8))
        manifest.addHash(name: "bye", data: Data("bye".utf8))

        let data = try manifest.makeData()
        let string = String(decoding: data, as: UTF8.self)
        XCTAssertEqual(string, """
            {
              "bye" : "78c9a53e2f28b543ea62c8266acfdf36d5c63e61",
              "hi" : "c22b5f9178342609428d6f51b2c5af4c0bde6a42"
            }
            """)
    }
}
