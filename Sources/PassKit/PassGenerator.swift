import Foundation
import Crypto
import ShellOut
import ZIPFoundation

public struct PassGenerator {
    public let archive: Archive
    
    /// Creates a pass generator object with a base folder location
    /// - Parameters:
    ///   - folder: base folder to create pass in. If not provided, this will create a folder in the temp directory
    ///   - fileManager: `FileManager` for customization if you don't want the stock default
    /// - Throws: `PassError` if target folder is not empty
    public init() throws {
        guard let archive = Archive(accessMode: .create) else {
            throw PassError.createArchive
        }
        
        self.archive = archive
    }
    
    /// Copies a file into the pass directory.
    /// - Parameters:
    ///   - from: location of file
    ///   - name: name for file inside the pass directory
    /// - Throws:
    ///
    /// This can be used to copy in images etc
    public func copy(itemAt from: URL, as name: String? = nil) throws {
        let data = try Data(contentsOf: from)
        try insert(data: data, as: name ?? from.lastPathComponent)
    }
    
    /// Copies a file into the pass directory.
    /// - Parameters:
    ///   - from: location of file
    ///   - name: name for file inside the pass directory
    /// - Throws:
    ///
    /// This can be used to copy in images etc
    public func insert(data: Data, as name: String) throws {
        try archive.addEntry(
            with: name,
            type: .file,
            uncompressedSize: UInt32(data.count),
            bufferSize: 4,
            provider: data.zipProvider
        )
    }
    
    /// Creates `pass.json` from a `Pass` object
    /// - Parameter pass: `Pass` object representing pass information
    /// - Throws:
    public func preparePass(pass: Pass) throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        let passData = try encoder.encode(pass)
        
        try insert(data: passData, as: "pass.json")
    }
    
    /// Creates manifest file describing pass contents
    /// - Throws:
    ///
    /// This function loops through all the files in the pass folder and calculates a SHA1 hash of each file.
    /// This hash is stored as a value, with the key being the file name.
    /// These pairings create the `manifest.json` describing the pacakge contents.
    public func generateManifest() throws {
        var manifest = [String: String]()
        
        try archive.forEach { entry in
            let _ = try archive.extract(entry) { data in
                let hashData = Insecure.SHA1.hash(data: data)
                manifest[entry.path] = hashData
                    .map { String(format: "%02hhx", $0) }
                    .joined()
            }
        }

        let manifestData = try JSONSerialization.data(withJSONObject: manifest, options: .prettyPrinted)
        try insert(data: manifestData, as: "manifest.json")
    }
    
    /// Generate signature of manifest file
    /// - Parameters:
    ///   - certificate: location of `cert.pem`
    ///   - key: location of `key.pem`
    ///   - wwdr: location of `wwdr.pem`
    ///   - password: password for certificates
    /// - Throws:
    public func generateSignature(certificate: URL, key: URL, wwdr: URL, password: String) throws {
        let tempFolder = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: tempFolder, withIntermediateDirectories: true, attributes: nil)
        defer {
            try? FileManager.default.removeItem(at: tempFolder)
        }
        let manifestUrl = tempFolder.appendingPathComponent("manifest.json")
        let signatureUrl = tempFolder.appendingPathComponent("signature")
        
        guard let entry = archive["manifest.json"] else {
            throw PassError.manifestWrite
        }
        
        let _ = try archive.extract(entry, to: manifestUrl)
        
        try shellOut(to: .generateSignature(
            certificate: certificate,
            key: key,
            wwdr: wwdr,
            manifest: manifestUrl,
            signature: signatureUrl,
            password: password
        ))
        
        try copy(itemAt: signatureUrl, as: "signature")
    }
    
    /// Create zip of pass folder - which is the the `.pkpass` object
    /// - Parameter url: location for pass to be created at
    /// - Throws:
    public func passData() throws -> Data {
        guard let data = archive.data else {
            throw PassError.passWrite
        }
        
        return data
    }
}
