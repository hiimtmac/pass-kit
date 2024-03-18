// CMSSignerIdentifier.swift
// Copyright (c) 2024 hiimtmac inc.

import SwiftASN1
import X509

/// ``CMSSignerIdentifier`` is defined in ASN.1 as:
/// ```
/// SignerIdentifier ::= CHOICE {
///   issuerAndSerialNumber IssuerAndSerialNumber,
///   subjectKeyIdentifier [0] SubjectKeyIdentifier }
///  ```
@usableFromInline
enum CMSSignerIdentifier: DERSerializable, Hashable, Sendable {
    case issuerAndSerialNumber(CMSIssuerAndSerialNumber)

    @inlinable
    init(issuerAndSerialNumber certificate: Certificate) {
        self = .issuerAndSerialNumber(.init(issuer: certificate.issuer, serialNumber: certificate.serialNumber))
    }

    @inlinable
    func serialize(into coder: inout DER.Serializer) throws {
        switch self {
        case let .issuerAndSerialNumber(issuerAndSerialNumber):
            try issuerAndSerialNumber.serialize(into: &coder)
        }
    }
}
