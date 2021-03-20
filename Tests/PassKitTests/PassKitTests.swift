import XCTest
@testable import PassKit

final class PassKitTests: XCTestCase {
    
    let fm = FileManager.default
    let url = URL(fileURLWithPath: NSTemporaryDirectory())
        .appendingPathComponent(UUID().uuidString)
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        try fm.removeItem(at: url)
    }
    
    func testInitThrowsWhenNonEmpty() throws {
        let doc = url.appendingPathComponent("doc")
        let data = Data("doc".utf8)
        try fm.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        fm.createFile(atPath: doc.path, contents: data, attributes: nil)
        XCTAssertThrowsError(try PassGenerator(folder: url))
    }
    
    func testInitCreatesDirectory() throws {
        let _ = try PassGenerator(folder: url, fileManager: fm)
        XCTAssert(fm.fileExists(atPath: url.path))
    }
    
    func testCopyWithName() throws {
        let gen = try PassGenerator(folder: url, fileManager: fm)
        let file = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(UUID().uuidString)
        let data = Data("doc".utf8)
//        fm.createFile(atPath: doc.path, contents: data, attributes: nil)
    }
    
    func testCopyWithoutName() throws {
        let gen = try PassGenerator(folder: url, fileManager: fm)
        
    }

    static var allTests = [
        ("testInitThrowsWhenNonEmpty", testInitThrowsWhenNonEmpty),
        ("testInitCreatesDirectory", testInitCreatesDirectory),
        ("testCopyWithName", testCopyWithName),
        ("testCopyWithoutName", testCopyWithoutName)
    ]
}
