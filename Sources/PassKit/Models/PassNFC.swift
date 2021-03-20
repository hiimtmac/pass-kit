import Foundation

public struct PassNFC: Codable {
    /// The payload to be transmitted to the Apple Pay terminal. Must be 64 bytes or less. Messages longer than 64 bytes are truncated by the system.
    public var message: String
    /// The public encryption key used by the Value Added Services protocol. Use a Base64 encoded X.509 SubjectPublicKeyInfo structure containing a ECDH public key for group P256.
    public var encryptionPublicKey: String?
    
    public init(
        message: String,
        encryptionPublicKey: String? = nil
    ) {
        self.message = message
        self.encryptionPublicKey = encryptionPublicKey
    }
}
