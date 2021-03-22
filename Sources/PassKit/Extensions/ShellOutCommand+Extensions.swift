import Foundation
import ShellOut

extension ShellOutCommand {
    /// Takes a `.p12` file and generates key needed for manifest signing
    /// - Parameters:
    ///   - certificateIn: location of `.p12` certificate
    ///   - keyOut: location for `key.pem` to be created
    ///   - password: password of `.p12`
    ///
    /// - Note: Requires `openssl` installed on machine running this command
    public static func generateKey(certificateIn: URL, keyOut: URL, password: String) -> ShellOutCommand {
        var command = "openssl pkcs12"
        command.append(" -in \(certificateIn.path)")
        command.append(" -nocerts")
        command.append(" -out \(keyOut.path)")
        command.append(" -passin pass:\(password)")
        command.append(" -passout pass:\(password)")
        
        return ShellOutCommand(string: command)
    }
    
    /// Takes a `.p12` file and generates certificate needed for manifest signing
    /// - Parameters:
    ///   - certificateIn: location of `.p12` certificate
    ///   - certificateOut: location for `cert.pem` to be created
    ///   - password: password of `.p12`
    ///
    /// - Note: Requires `openssl` installed on machine running this command
    public static func generateCertificate(certificateIn: URL, certificateOut: URL, password: String) -> ShellOutCommand {
        var command = "openssl pkcs12"
        command.append(" -in \(certificateIn.path)")
        command.append(" -clcerts")
        command.append(" -nokeys")
        command.append(" -out \(certificateOut.path)")
        command.append(" -passin pass:\(password)")
        
        return ShellOutCommand(string: command)
    }
    
    /// Generates signature of manifest file
    /// - Parameters:
    ///   - certificate: location of `cert.pem` certificate
    ///   - key: location of `key.pem` key
    ///   - wwdr: location of `wwdr.pem` certificate
    ///   - manifest: location of `manifest.json`
    ///   - signature: location to generate `signature`
    ///   - password: password for `.p12`
    ///
    /// - Note: Requires `openssl` installed on machine running this command
    public static func generateSignature(certificate: URL, key: URL, wwdr: URL, manifest: URL, signature: URL, password: String) -> ShellOutCommand {
        var command = "openssl smime"
        command.append(" -sign")
        command.append(" -signer \(certificate.path)")
        command.append(" -inkey \(key.path)")
        command.append(" -certfile \(wwdr.path)")
        command.append(" -in \(manifest.path)")
        command.append(" -out \(signature.path)")
        command.append(" -outform DER")
        command.append(" -binary")
        command.append(" -passin pass:\(password)")
        
        return ShellOutCommand(string: command)
    }
}
