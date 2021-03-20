import ArgumentParser
import Foundation
import ShellOut

public struct CertificateCommand: ParsableCommand {
    public static let configuration = CommandConfiguration(commandName: "certgen", abstract: "generates signing certificate")
    
    @Argument(completion: .file(extensions: ["p12"]), transform: fileTransform)
    var input: URL
    
    @Option(name: .shortAndLong, completion: .directory, transform: folderTransform)
    var output: URL?
    
    @Option(name: .shortAndLong, help: "Certificate password")
    var password: String?
    
    public init() {}
    
    public func run() throws {
        let out = output ?? input.deletingLastPathComponent().appendingPathComponent("cert.pem")

        try shellOut(to: .generateCertificate(
            certificateIn: input,
            certificateOut: out,
            password: password ?? ""
        ))
    }
}
