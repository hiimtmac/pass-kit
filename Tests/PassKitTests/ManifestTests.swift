// ManifestTests.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation
import Testing
@testable import PassGen

@Suite
struct ManifestTests {
    @Test
    func generateManifest() throws {
        var manifest = Manifest()
        manifest.addHash(name: "hi", data: Data("hi".utf8))
        manifest.addHash(name: "bye", data: Data("bye".utf8))

        let data = try manifest.makeData()
        #expect(String(decoding: data, as: UTF8.self) == """
            {
              "bye" : "78c9a53e2f28b543ea62c8266acfdf36d5c63e61",
              "hi" : "c22b5f9178342609428d6f51b2c5af4c0bde6a42"
            }
            """)
    }
}
