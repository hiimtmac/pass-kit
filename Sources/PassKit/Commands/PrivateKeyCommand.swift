import ArgumentParser
import Foundation
import ShellOut

public struct PrivateKeyCommand: ParsableCommand {
    public static let configuration = CommandConfiguration(commandName: "keygen", abstract: "generates private signing key")
    
    @Argument(completion: .file(extensions: ["p12"]), transform: fileTransform)
    var input: URL
    
    @Option(name: .shortAndLong, completion: .directory, transform: folderTransform)
    var output: URL?
    
    @Option(name: .shortAndLong, help: "Certificate password")
    var password: String?
    
    public init() {}
    
    public func run() throws {
        let out = output ?? input.deletingLastPathComponent().appendingPathComponent("key.pem")

        try shellOut(to: .generateKey(
            certificateIn: input,
            keyOut: out,
            password: password ?? ""
        ))
    }
}
