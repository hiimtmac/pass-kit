// CMSIssuerAndSerialNumber.swift
// Copyright (c) 2024 hiimtmac inc.

import SwiftASN1
import X509

/// ``CMSIssuerAndSerialNumber`` is defined in ASN.1 as:
/// ```
/// IssuerAndSerialNumber ::= SEQUENCE {
///         issuer Name,
///         serialNumber CertificateSerialNumber }
/// ```
/// The definition of `Name` is taken from X.501 [X.501-88], and the
/// definition of `CertificateSerialNumber` is taken from X.509 [X.509-97].
@usableFromInline
struct CMSIssuerAndSerialNumber: DERSerializable {
    @usableFromInline
    var issuer: DistinguishedName

    @usableFromInline
    var serialNumber: Certificate.SerialNumber

    @inlinable
    init(
        issuer: DistinguishedName,
        serialNumber: Certificate.SerialNumber
    ) {
        self.issuer = issuer
        self.serialNumber = serialNumber
    }

    @inlinable
    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(self.issuer)
            try coder.serialize(self.serialNumber.bytes)
        }
    }
}
