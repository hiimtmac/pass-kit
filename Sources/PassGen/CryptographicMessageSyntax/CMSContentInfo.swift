// CMSContentInfo.swift
// Copyright (c) 2025 hiimtmac inc.

import SwiftASN1

extension ASN1ObjectIdentifier {
    /// Cryptographic Message Syntax (CMS) Signed Data.
    ///
    /// ASN.1 definition:
    /// ```
    /// id-signedData OBJECT IDENTIFIER ::= { iso(1) member-body(2)
    ///    us(840) rsadsi(113549) pkcs(1) pkcs7(7) 2 }
    /// ```
    @usableFromInline
    static let cmsSignedData: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 7, 2]
}

/// ``ContentInfo`` is defined in ASN.1 as:
/// ```
/// ContentInfo ::= SEQUENCE {
///   contentType ContentType,
///   content [0] EXPLICIT ANY DEFINED BY contentType }
/// ContentType ::= OBJECT IDENTIFIER
/// ```
@usableFromInline
struct CMSContentInfo: DERSerializable, Hashable, Sendable {
    @usableFromInline
    var contentType: ASN1ObjectIdentifier

    @usableFromInline
    var content: ASN1Any

    @inlinable
    init(contentType: ASN1ObjectIdentifier, content: ASN1Any) {
        self.contentType = contentType
        self.content = content
    }

    @inlinable
    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(contentType)
            try coder.serialize(explicitlyTaggedWithTagNumber: 0, tagClass: .contextSpecific) { coder in
                try coder.serialize(content)
            }
        }
    }
}

extension CMSContentInfo {
    @inlinable
    init(_ signedData: CMSSignedData) throws {
        try self.init(
            contentType: .cmsSignedData,
            content: ASN1Any(erasing: signedData)
        )
    }
}
