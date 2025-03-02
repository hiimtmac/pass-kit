// CMSEncapsulatedContentInfo.swift
// Copyright (c) 2025 hiimtmac inc.

import SwiftASN1

extension ASN1ObjectIdentifier {
    /// Cryptographic Message Syntax (CMS) Data.
    ///
    /// ASN.1 definition:
    /// ```
    /// id-data OBJECT IDENTIFIER ::= { iso(1) member-body(2)
    ///    us(840) rsadsi(113549) pkcs(1) pkcs7(7) 1 }
    /// ```
    @usableFromInline
    static let cmsData: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 7, 1]
}

/// ``CMSEncapsulatedContentInfo`` is defined in ASN.1 as:
/// ```
/// EncapsulatedContentInfo ::= SEQUENCE {
///   eContentType ContentType,
///   eContent [0] EXPLICIT OCTET STRING OPTIONAL }
/// ContentType ::= OBJECT IDENTIFIER
/// ```
@usableFromInline
struct CMSEncapsulatedContentInfo: DERSerializable, Hashable, Sendable {
    @usableFromInline
    var eContentType: ASN1ObjectIdentifier

    @usableFromInline
    var eContent: ASN1OctetString?

    @inlinable
    init(eContentType: ASN1ObjectIdentifier, eContent: ASN1OctetString? = nil) {
        self.eContentType = eContentType
        self.eContent = eContent
    }

    @inlinable
    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(eContentType)
            if let eContent {
                try coder.serialize(explicitlyTaggedWithTagNumber: 0, tagClass: .contextSpecific) { coder in
                    try coder.serialize(eContent)
                }
            }
        }
    }
}

extension CMSEncapsulatedContentInfo {
    @usableFromInline
    static let cmsData = CMSEncapsulatedContentInfo(eContentType: .cmsData)
}
