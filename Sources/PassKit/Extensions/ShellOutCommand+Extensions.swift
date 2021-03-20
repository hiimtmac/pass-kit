import Foundation
import ShellOut

extension ShellOutCommand {
    public static func generateKey(certificateIn: URL, keyOut: URL, password: String) -> ShellOutCommand {
        
        var command = "openssl pkcs12"
        command.append(" -in \(certificateIn.path)")
        command.append(" -nocerts")
        command.append(" -out \(keyOut.path)")
        command.append(" -passin pass:\(password)")
        command.append(" -passout pass:\(password)")
        
        return ShellOutCommand(string: command)
    }
    
    public static func generateCertificate(certificateIn: URL, certificateOut: URL, password: String) -> ShellOutCommand {
        
        var command = "openssl pkcs12"
        command.append(" -in \(certificateIn.path)")
        command.append(" -clcerts")
        command.append(" -nokeys")
        command.append(" -out \(certificateOut.path)")
        command.append(" -passin pass:\(password)")
        
        return ShellOutCommand(string: command)
    }
    
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
