// ManifestTests.swift
// Copyright (c) 2024 hiimtmac inc.

import XCTest
@testable import PassGen

final class ManifestTests: XCTestCase {
    func testGenerateManifest() throws {
        var manifest = Manifest()
        manifest.addHash(name: "hi", data: Data("hi".utf8))
        manifest.addHash(name: "bye", data: Data("bye".utf8))

        let data = try manifest.makeData()
        XCTAssertEqual(String(decoding: data, as: UTF8.self), """
            {
              "bye" : "78c9a53e2f28b543ea62c8266acfdf36d5c63e61",
              "hi" : "c22b5f9178342609428d6f51b2c5af4c0bde6a42"
            }
            """)
    }
}
