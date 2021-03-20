import Foundation
import Crypto
import ShellOut
import ZIPFoundation

// https://www.raywenderlich.com/2855-beginning-passbook-in-ios-6-part-1-2
private let temp = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)

public struct PassGenerator {
    let folder: URL
    let fileManager: FileManager
        
    public init(folder: URL? = nil, fileManager: FileManager = .default) throws {
        self.folder = folder ?? temp.appendingPathComponent(UUID().uuidString)
        self.fileManager = fileManager
        
        if try
            self.fileManager.fileExists(atPath: self.folder.path) &&
            !self.fileManager.contentsOfDirectory(atPath: self.folder.path).isEmpty
        {
            throw PassError.nonEmptyDirectory
        }
    }
    
    public func setup() throws {
        try fileManager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
    }
    
    public func copy(itemAt from: URL, as name: String? = nil) throws {
        let to = folder.appendingPathComponent(name ?? from.lastPathComponent)
        try fileManager.copyItem(at: from, to: to)
    }
    
    public func preparePass(pass: Pass) throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        let passData = try encoder.encode(pass)
        
        let passUrl = folder.appendingPathComponent("pass.json")
        
        let write = fileManager.createFile(atPath: passUrl.path, contents: passData, attributes: nil)
        if !write {
            throw PassError.passWrite
        }
    }
    
    public func generateManifest() throws {
        let manifest = try fileManager.contentsOfDirectory(
            at: folder,
            includingPropertiesForKeys: nil,
            options: [.skipsHiddenFiles]
        )
        .reduce(into: [String: String]()) { manifest, url in
            let data = try Data(contentsOf: url)
            let hashData = Insecure.SHA1.hash(data: data)
            
            manifest[url.lastPathComponent] = hashData.map { String(format: "%02hhx", $0) }.joined()
        }
        
        let manifestData = try JSONSerialization.data(withJSONObject: manifest, options: .prettyPrinted)
        
        let manifestUrl = folder.appendingPathComponent("manifest.json")
        
        let write = fileManager.createFile(atPath: manifestUrl.path, contents: manifestData, attributes: nil)
        if !write {
            throw PassError.manifestWrite
        }
    }
    
    public func generateSignature(certificate: URL, key: URL, wwdr: URL, password: String) throws {
        try shellOut(to: .generateSignature(
            certificate: certificate,
            key: key,
            wwdr: wwdr,
            manifest: folder.appendingPathComponent("manifest.json"),
            signature: folder.appendingPathComponent("signature"),
            password: password
        ))
    }
    
    public func zipPass(url: URL) throws {
        try fileManager.zipItem(at: folder, to: url, shouldKeepParent: false)
    }
    
    public func cleanup() throws {
        try fileManager.removeItem(at: folder)
    }
}
