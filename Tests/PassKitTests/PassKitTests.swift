import XCTest
import ZIPFoundation
@testable import PassKit

final class PassKitTests: XCTestCase {
    
    let fm = FileManager.default
    
    func testCopyWithoutName() throws {
        let gen = try PassGenerator()
        let file = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("file")
        defer {
            try! fm.removeItem(at: file)
        }
        let data = Data("doc".utf8)
        fm.createFile(atPath: file.path, contents: data, attributes: nil)
        XCTAssert(fm.fileExists(atPath: file.path))

        try gen.copy(itemAt: file)

        let entry = try XCTUnwrap(gen.archive["file"])
        let _ = try gen.archive.extract(entry) { data in
            XCTAssertEqual(String(decoding: data, as: UTF8.self), "doc")
        }
    }
    
    func testCopyWithName() throws {
        let gen = try PassGenerator()
        let file = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("file")
        defer {
            try! fm.removeItem(at: file)
        }
        let data = Data("doc".utf8)
        fm.createFile(atPath: file.path, contents: data, attributes: nil)
        XCTAssert(fm.fileExists(atPath: file.path))

        try gen.copy(itemAt: file, as: "cool")

        let entry = try XCTUnwrap(gen.archive["cool"])
        let _ = try gen.archive.extract(entry) { data in
            XCTAssertEqual(String(decoding: data, as: UTF8.self), "doc")
        }
    }
    
    func testPreparePass() throws {
        let gen = try PassGenerator()

        let pass = Pass(
            description: "desc",
            formatVersion: 1,
            organizationName: "org",
            passTypeIdentifier: "id",
            serialNumber: "serial",
            teamIdentifier: "team"
        )

        try gen.preparePass(pass: pass)
        
        let entry = try XCTUnwrap(gen.archive["pass.json"])
        let _ = try gen.archive.extract(entry) { data in
            let decode = try JSONDecoder().decode(Pass.self, from: data)
            XCTAssertEqual(decode.description, pass.description)
            XCTAssertEqual(decode.formatVersion, pass.formatVersion)
            XCTAssertEqual(decode.organizationName, pass.organizationName)
            XCTAssertEqual(decode.passTypeIdentifier, pass.passTypeIdentifier)
            XCTAssertEqual(decode.serialNumber, pass.serialNumber)
            XCTAssertEqual(decode.teamIdentifier, pass.teamIdentifier)
        }
    }
    
    func testGenerateManifest() throws {
        let gen = try PassGenerator()
        let f1Data = Data("f1".utf8)
        let f2Data = Data("f2".utf8)
        
        try gen.insert(data: f1Data, as: "f1")
        try gen.insert(data: f2Data, as: "f2")
        
        try gen.generateManifest()
        
        let entry = try XCTUnwrap(gen.archive["manifest.json"])
        let _ = try gen.archive.extract(entry) { data in
            struct Manifest: Codable, Equatable {
                let f1: String
                let f2: String
            }
            
            let manifest = try JSONDecoder().decode(Manifest.self, from: data)
            let compare = Manifest(f1: "c09bb890b096f7306f688cc6d1dad34e7e52a223", f2: "cf1126f67238bf3e85fcc8c8737b72e80ddcfddb")
            
            XCTAssertEqual(manifest, compare)
        }
    }

    static var allTests = [
        ("testCopyWithName", testCopyWithName),
        ("testCopyWithoutName", testCopyWithoutName),
        ("testPreparePass", testPreparePass),
        ("testGenerateManifest", testGenerateManifest)
    ]
}
