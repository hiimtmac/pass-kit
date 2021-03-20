import Foundation
import Crypto
import ShellOut
import ZIPFoundation

private let temp = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)

public struct PassGenerator {
    public let folder: URL
    public let fileManager: FileManager
        
    
    /// Creates a pass generator object with a base folder location
    /// - Parameters:
    ///   - folder: base folder to create pass in. If not provided, this will create a folder in the temp directory
    ///   - fileManager: `FileManager` for customization if you don't want the stock default
    /// - Throws: `PassError` if target folder is not empty
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
    
    /// Creates folder for pass files to be created in
    /// - Throws:
    public func setup() throws {
        try fileManager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
    }
    
    /// Copies a file into the pass directory.
    /// - Parameters:
    ///   - from: location of file
    ///   - name: name for file inside the pass directory
    /// - Throws:
    ///
    /// This can be used to copy in images etc
    public func copy(itemAt from: URL, as name: String? = nil) throws {
        let to = folder.appendingPathComponent(name ?? from.lastPathComponent)
        try fileManager.copyItem(at: from, to: to)
    }
    
    /// Creates `pass.json` from a `Pass` object
    /// - Parameter pass: `Pass` object representing pass information
    /// - Throws:
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
    
    /// Creates manifest file describing pass contents
    /// - Throws:
    ///
    /// This function loops through all the files in the pass folder and calculates a SHA1 hash of each file.
    /// This hash is stored as a value, with the key being the file name.
    /// These pairings create the `manifest.json` describing the pacakge contents.
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
    
    /// Generate signature of manifest file
    /// - Parameters:
    ///   - certificate: location of `cert.pem`
    ///   - key: location of `key.pem`
    ///   - wwdr: location of `wwdr.pem`
    ///   - password: password for certificates
    /// - Throws:
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
    
    /// Create zip of pass folder - which is the the `.pkpass` object
    /// - Parameter url: location for pass to be created at
    /// - Throws:
    public func zipPass(url: URL) throws {
        try fileManager.zipItem(at: folder, to: url, shouldKeepParent: false)
    }
    
    /// Cleanup folder contents and delete working pass folder
    /// - Throws:
    public func cleanup() throws {
        try fileManager.removeItem(at: folder)
    }
}
