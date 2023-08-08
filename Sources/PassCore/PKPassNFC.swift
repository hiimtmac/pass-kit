// PKPassNFC.swift
// Copyright (c) 2023 hiimtmac inc.

import Foundation

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/LowerLevel.html#//apple_ref/doc/uid/TP40012026-CH3-SW5
/// Information about the NFC payload passed to an Apple Pay terminal.
public struct PKPassNFC: Codable, Equatable, Hashable {
    /// The payload to be transmitted to the Apple Pay terminal. Must be 64 bytes or less. Messages longer than 64 bytes are truncated by the system.
    public var message: String
    /// The public encryption key used by the Value Added Services protocol. Use a Base64 encoded X.509 SubjectPublicKeyInfo structure containing a ECDH public key for group P256.
    public var encryptionPublicKey: String?

    /// Information about the NFC payload passed to an Apple Pay terminal.
    /// - Parameters:
    ///   - message: The payload to be transmitted to the Apple Pay terminal
    ///   - encryptionPublicKey: The public encryption key used by the Value Added Services protocol
    public init(
        message: String,
        encryptionPublicKey: String? = nil
    ) {
        self.message = message
        self.encryptionPublicKey = encryptionPublicKey
    }
}
