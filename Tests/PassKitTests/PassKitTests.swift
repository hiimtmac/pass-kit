// PassKitTests.swift
// Copyright © 2022 hiimtmac

import XCTest
@testable import PassKit

final class PassKitTests: XCTestCase {
    let fm = FileManager.default
    let url = FileManager.default
        .temporaryDirectory
        .appendingPathComponent(UUID().uuidString)

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        try self.fm.removeItem(at: self.url)
    }

    func testInitThrowsWhenNonEmpty() throws {
        let doc = self.url.appendingPathComponent("doc")
        let data = Data("doc".utf8)
        try self.fm.createDirectory(at: self.url, withIntermediateDirectories: true, attributes: nil)
        self.fm.createFile(atPath: doc.path, contents: data, attributes: nil)
        XCTAssertThrowsError(try PassGenerator(folder: self.url))
    }

    func testInitCreatesDirectory() throws {
        let _ = try PassGenerator(folder: url, fileManager: fm)
        XCTAssert(self.fm.fileExists(atPath: self.url.path))
    }

    func testCopyWithName() throws {
        let gen = try PassGenerator(folder: url, fileManager: fm)
        let file = FileManager.default.temporaryDirectory.appendingPathComponent("file")
        defer {
            try? fm.removeItem(at: file)
        }
        let data = Data("doc".utf8)
        self.fm.createFile(atPath: file.path, contents: data, attributes: nil)
        XCTAssert(self.fm.fileExists(atPath: file.path))

        try gen.copy(itemAt: file)

        XCTAssert(self.fm.fileExists(atPath: gen.folder.appendingPathComponent("file").path))
    }

    func testCopyWithoutName() throws {
        let gen = try PassGenerator(folder: url, fileManager: fm)
        let file = FileManager.default.temporaryDirectory.appendingPathComponent("file")
        defer {
            try? fm.removeItem(at: file)
        }
        let data = Data("doc".utf8)
        self.fm.createFile(atPath: file.path, contents: data, attributes: nil)
        XCTAssert(self.fm.fileExists(atPath: file.path))

        try gen.copy(itemAt: file, as: "cool")

        XCTAssert(self.fm.fileExists(atPath: gen.folder.appendingPathComponent("cool").path))
    }

    func testPreparePass() throws {
        let gen = try PassGenerator(folder: url, fileManager: fm)

        let pass = Pass(description: "desc", organizationName: "org", passTypeIdentifier: "id", serialNumber: "serial", teamIdentifier: "team")

        try gen.preparePass(pass: pass)
        XCTAssert(self.fm.fileExists(atPath: gen.folder.appendingPathComponent("pass.json").path))

        let data = try Data(contentsOf: gen.folder.appendingPathComponent("pass.json"))
        let decode = try JSONDecoder().decode(Pass.self, from: data)
        XCTAssertEqual(decode.description, pass.description)
        XCTAssertEqual(decode.formatVersion, pass.formatVersion)
        XCTAssertEqual(decode.organizationName, pass.organizationName)
        XCTAssertEqual(decode.passTypeIdentifier, pass.passTypeIdentifier)
        XCTAssertEqual(decode.serialNumber, pass.serialNumber)
        XCTAssertEqual(decode.teamIdentifier, pass.teamIdentifier)
    }

    func testGenerateManifest() throws {
        let gen = try PassGenerator(folder: url, fileManager: fm)
        let f1Data = Data("f1".utf8)
        let f2Data = Data("f2".utf8)

        try f1Data.write(to: gen.folder.appendingPathComponent("f1"))
        try f2Data.write(to: gen.folder.appendingPathComponent("f2"))

        XCTAssert(self.fm.fileExists(atPath: gen.folder.appendingPathComponent("f1").path))
        XCTAssert(self.fm.fileExists(atPath: gen.folder.appendingPathComponent("f2").path))

        try gen.generateManifest()

        let data = try Data(contentsOf: gen.folder.appendingPathComponent("manifest.json"))

        struct Manifest: Codable, Equatable {
            let f1: String
            let f2: String
        }

        let manifest = try JSONDecoder().decode(Manifest.self, from: data)

        XCTAssertEqual(manifest, .init(f1: "c09bb890b096f7306f688cc6d1dad34e7e52a223", f2: "cf1126f67238bf3e85fcc8c8737b72e80ddcfddb"))
    }

    static var allTests = [
        ("testInitThrowsWhenNonEmpty", testInitThrowsWhenNonEmpty),
        ("testInitCreatesDirectory", testInitCreatesDirectory),
        ("testCopyWithName", testCopyWithName),
        ("testCopyWithoutName", testCopyWithoutName),
        ("testPreparePass", testPreparePass),
        ("testGenerateManifest", testGenerateManifest),
    ]
}
