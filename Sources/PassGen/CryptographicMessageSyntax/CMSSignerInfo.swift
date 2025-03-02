// CMSSignerInfo.swift
// Copyright (c) 2025 hiimtmac inc.

import SwiftASN1

/// ``CMSSignerInfo`` is defined in ASN.1 as:
/// ```
/// SignerInfo ::= SEQUENCE {
///   version CMSVersion,
///   sid SignerIdentifier,
///   digestAlgorithm DigestAlgorithmIdentifier,
///   signedAttrs [0] IMPLICIT SignedAttributes OPTIONAL,
///   signatureAlgorithm SignatureAlgorithmIdentifier,
///   signature SignatureValue,
///   unsignedAttrs [1] IMPLICIT UnsignedAttributes OPTIONAL }
///
/// SignatureValue ::= OCTET STRING
/// DigestAlgorithmIdentifier ::= AlgorithmIdentifier
/// SignatureAlgorithmIdentifier ::= AlgorithmIdentifier
/// ```
/// - Note: If the `SignerIdentifier` is the CHOICE `issuerAndSerialNumber`,
/// then the `version` MUST be 1.  If the `SignerIdentifier` is `subjectKeyIdentifier`,
/// then the `version` MUST be 3.
@usableFromInline
struct CMSSignerInfo: DERSerializable, Hashable, Sendable {
    @usableFromInline
    var version: CMSVersion

    @usableFromInline
    var signerIdentifier: CMSSignerIdentifier

    @usableFromInline
    var digestAlgorithm: AlgorithmIdentifier

    @usableFromInline
    var signedAttrs: [CMSAttribute]?

    @usableFromInline
    var signatureAlgorithm: AlgorithmIdentifier

    @usableFromInline
    var signature: ASN1OctetString

    @usableFromInline
    var unsignedAttrs: [CMSAttribute]?

    @inlinable
    init(
        version: CMSVersion,
        signerIdentifier: CMSSignerIdentifier,
        digestAlgorithm: AlgorithmIdentifier,
        signedAttrs: [CMSAttribute]? = nil,
        signatureAlgorithm: AlgorithmIdentifier,
        signature: ASN1OctetString,
        unsignedAttrs: [CMSAttribute]? = nil
    ) {
        self.version = version
        self.signerIdentifier = signerIdentifier
        self.digestAlgorithm = digestAlgorithm
        self.signedAttrs = signedAttrs
        self.signatureAlgorithm = signatureAlgorithm
        self.signature = signature
        self.unsignedAttrs = unsignedAttrs
    }

    @inlinable
    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(self.version.rawValue)
            try coder.serialize(self.signerIdentifier)
            try coder.serialize(self.digestAlgorithm)
            if let signedAttrs = self.signedAttrs {
                try coder.serializeSetOf(signedAttrs, identifier: .init(tagWithNumber: 0, tagClass: .contextSpecific))
            }
            try coder.serialize(self.signatureAlgorithm)
            try coder.serialize(self.signature)
            if let unsignedAttrs = self.unsignedAttrs {
                try coder.serializeSetOf(unsignedAttrs, identifier: .init(tagWithNumber: 1, tagClass: .contextSpecific))
            }
        }
    }
}
