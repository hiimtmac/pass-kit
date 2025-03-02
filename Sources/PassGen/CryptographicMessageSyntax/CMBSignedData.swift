// CMBSignedData.swift
// Copyright (c) 2025 hiimtmac inc.

import SwiftASN1
import X509

/// ``SignedData`` is defined in ASN.1 as:
/// ```
/// SignedData ::= SEQUENCE {
///   version CMSVersion,
///   digestAlgorithms DigestAlgorithmIdentifiers,
///   encapContentInfo EncapsulatedContentInfo,
///   certificates [0] IMPLICIT CertificateSet OPTIONAL,
///   crls [1] IMPLICIT RevocationInfoChoices OPTIONAL,
///   signerInfos SignerInfos }
///
/// DigestAlgorithmIdentifiers ::= SET OF DigestAlgorithmIdentifier
/// DigestAlgorithmIdentifier ::= AlgorithmIdentifier
/// SignerInfos ::= SET OF SignerInfo
/// CertificateSet ::= SET OF CertificateChoices
///
/// CertificateChoices ::= CHOICE {
///  certificate Certificate,
///  extendedCertificate [0] IMPLICIT ExtendedCertificate, -- Obsolete
///  v1AttrCert [1] IMPLICIT AttributeCertificateV1,       -- Obsolete
///  v2AttrCert [2] IMPLICIT AttributeCertificateV2,
///  other [3] IMPLICIT OtherCertificateFormat }
///
/// OtherCertificateFormat ::= SEQUENCE {
///   otherCertFormat OBJECT IDENTIFIER,
///   otherCert ANY DEFINED BY otherCertFormat }
/// ```
/// - Note: At the moment we don't support `crls` (`RevocationInfoChoices`)
@usableFromInline
struct CMSSignedData: DERSerializable, Hashable, Sendable {
    @usableFromInline
    var version: CMSVersion

    @usableFromInline
    var digestAlgorithms: [AlgorithmIdentifier]

    @usableFromInline
    var encapContentInfo: CMSEncapsulatedContentInfo

    @usableFromInline
    var certificates: [Certificate]?

    @usableFromInline
    var signerInfos: [CMSSignerInfo]

    @inlinable
    init(
        version: CMSVersion,
        digestAlgorithms: [AlgorithmIdentifier],
        encapContentInfo: CMSEncapsulatedContentInfo,
        certificates: [Certificate]?,
        signerInfos: [CMSSignerInfo]
    ) {
        self.version = version
        self.digestAlgorithms = digestAlgorithms
        self.encapContentInfo = encapContentInfo
        self.certificates = certificates
        self.signerInfos = signerInfos
    }

    @inlinable
    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(version.rawValue)
            try coder.serializeSetOf(digestAlgorithms)
            try coder.serialize(encapContentInfo)
            if let certificates {
                try coder.serializeSetOf(certificates, identifier: .init(tagWithNumber: 0, tagClass: .contextSpecific))
            }
            try coder.serializeSetOf(signerInfos, identifier: .set)
        }
    }
}
