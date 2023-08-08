// PassKitTests.swift
// Copyright (c) 2023 hiimtmac inc.

import PassCore
import XCTest
@testable import PassGen

final class PassKitTests: XCTestCase {
    func testGenerateManifest() throws {
        let manifest = Manifest()
        manifest.addHash(name: "hi", data: "hi".asData)
        manifest.addHash(name: "bye", data: "bye".asData)

        let data = try manifest.makeData()
        XCTAssertEqual(data.asString, """
            {
              "bye" : "78c9a53e2f28b543ea62c8266acfdf36d5c63e61",
              "hi" : "c22b5f9178342609428d6f51b2c5af4c0bde6a42"
            }
            """)
    }
    
    func testAddItems() throws {
        let generator = try PassGenerator()
        try generator.add(pass: .init(description: "", organizationName: "", passTypeIdentifier: "", serialNumber: "", teamIdentifier: ""))
        try generator.add(image: "background".asData, as: .background(.x1))
        try generator.add(image: "strip@2x".asData, as: .strip(.x2), localization: "en")
        try generator.add(strings: "hello".asData, for: "fr")
        try generator.add(manifest: "manifest".asData)
        try generator.add(signature: "signature".asData)
        
        let entries = generator.archive.map(\.path).sorted()
        XCTAssertEqual(entries, [
            "background.png",
            "en.lproj/strip@2x.png",
            "fr.lproj/pass.strings",
            "manifest.json",
            "pass.json",
            "signature"
        ])
        
        let manifest = try generator.manifest.makeData()
        XCTAssertEqual(manifest.asString, #"""
            {
              "background.png" : "248a20b62efba8f4303c75830c83230f1b088f1e",
              "en.lproj\/strip@2x.png" : "7f43a4b8b7b4436fb4271e51b9d8c55334f26c59",
              "fr.lproj\/pass.strings" : "aaf4c61ddcc5e8a2dabede0f3b482cd9aea9434d",
              "pass.json" : "5e9fde65c087932395ddff7faf54fa0625f8453c"
            }
            """#)
    }
}

extension Data {
    var asString: String {
        String(decoding: self, as: UTF8.self)
    }
}

extension String {
    var asData: Data {
        Data(self.utf8)
    }
}
