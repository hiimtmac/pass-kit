// NFC.swift
// Copyright (c) 2025 hiimtmac inc.

// hhttps://developer.apple.com/documentation/walletpasses/pass/nfc
extension Pass {
    /// Information about the NFC payload passed to an Apple Pay terminal.
    public struct NFC: Codable, Equatable, Hashable, Sendable {
        /// The public encryption key used by the Value Added Services protocol.
        ///
        /// Use a Base64 encoded X.509 SubjectPublicKeyInfo structure containing a ECDH public key for group P256.
        public var encryptionPublicKey: String?

        /// The payload to be transmitted to the Apple Pay terminal.
        ///
        /// Must be 64 bytes or less. Messages longer than 64 bytes are truncated by the system.
        public var message: String

        /// A Boolean value that indicates whether the NFC pass requires authentication.
        ///
        /// The default value is `false`.
        /// A value of true requires the user to authenticate for each use of the NFC pass.
        ///
        /// This key is valid in iOS 13.1 and later.
        ///
        /// Set ``sharingProhibited`` to `true` to prevent users from sharing passes with older iOS versions and bypassing the authentication requirement.
        public var requiresAuthentication: Bool?

        /// Information about the NFC payload passed to an Apple Pay terminal.
        /// - Parameters:
        ///   - encryptionPublicKey: The public encryption key used by the Value Added Services protocol
        ///   - message: The payload to be transmitted to the Apple Pay terminal
        ///   - requiresAuthentication: A Boolean value that indicates whether the NFC pass requires authentication. The default value is false. A value of true requires the user to authenticate for each use of the NFC pass.
        public init(
            encryptionPublicKey: String? = nil,
            message: String,
            requiresAuthentication: Bool? = nil
        ) {
            self.encryptionPublicKey = encryptionPublicKey
            self.message = message
            self.requiresAuthentication = requiresAuthentication
        }
    }
}
