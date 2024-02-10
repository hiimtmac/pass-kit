// CMSAttribute.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation
import SwiftASN1

extension ASN1ObjectIdentifier {
    static let contentType: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 9, 3]
    static let signingTime: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 9, 5]
    static let messageDigest: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 9, 4]

    static let pkcs7Data: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 7, 1]
}

/// ``CMSAttribute`` is defined in ASN.1 as:
/// ```
/// Attribute ::= SEQUENCE {
///     attrType OBJECT IDENTIFIER,
///     attrValues SET OF AttributeValue }
///
/// AttributeValue ::= ANY
/// ```
@usableFromInline
struct CMSAttribute: DERSerializable {
    @usableFromInline
    var attrType: ASN1ObjectIdentifier

    @usableFromInline
    var attrValues: [ASN1Any]

    @inlinable
    init(attrType: ASN1ObjectIdentifier, attrValues: [ASN1Any]) {
        self.attrType = attrType
        self.attrValues = attrValues
    }

    @inlinable
    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(self.attrType)
            try coder.serializeSetOf(self.attrValues)
        }
    }
}

extension CMSAttribute {
    @inlinable
    init(attrType: ASN1ObjectIdentifier, attrValue: ASN1Any) {
        self.attrType = attrType
        self.attrValues = [attrValue]
    }

    static let contentType = CMSAttribute(
        attrType: .contentType,
        attrValue: try! ASN1Any(erasing: ASN1ObjectIdentifier.pkcs7Data)
    )

    static func signingTime(date: Date = .now) -> CMSAttribute {
        .init(
            attrType: .signingTime,
            attrValue: try! ASN1Any(erasing: UTCTime(date: date))
        )
    }

    static func messageDigest(signature: ASN1OctetString) -> CMSAttribute {
        .init(
            attrType: .messageDigest,
            attrValue: try! ASN1Any(erasing: signature)
        )
    }
}

extension UTCTime {
    init(date: Date = .now) throws {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!

        try self.init(
            year: calendar.component(.year, from: date),
            month: calendar.component(.month, from: date),
            day: calendar.component(.day, from: date),
            hours: calendar.component(.hour, from: date),
            minutes: calendar.component(.minute, from: date),
            seconds: calendar.component(.second, from: date)
        )
    }
}

// When reversing the signature produced by openssl smime command it included this smime capabilities
// but seems passkit signing doesnt actually need - only requires message digest, signing time, content
// type as signed attributes. Leaving here in case needed later

// extension ASN1ObjectIdentifier {
//    static let smimeCapabilities: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 9, 15]
//    static let aes256cbc: ASN1ObjectIdentifier = [2, 16, 840, 1, 101, 3, 4, 1, 42]
//    static let aes192cbc: ASN1ObjectIdentifier = [2, 16, 840, 1, 101, 3, 4, 1, 22]
//    static let aes128cbc: ASN1ObjectIdentifier = [2, 16, 840, 1, 101, 3, 4, 1, 2]
//    static let desede3cbc: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 3, 7]
//    static let rc2cbc: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 3, 2]
//    static let descbc: ASN1ObjectIdentifier = [1, 3, 14, 3, 2, 7]
// }
//
// struct SMIMECapabilitiesAttribute: DERSerializable {
//    let oid: ASN1ObjectIdentifier = .smimeCapabilities
//
//    func serialize(into coder: inout DER.Serializer) throws {
//        try coder.appendConstructedNode(identifier: .sequence) { coder in
//            try coder.serialize(self.oid)
//            try coder.appendConstructedNode(identifier: .set) { coder in
//                try coder.appendConstructedNode(identifier: .sequence) { coder in
//                    try coder.serialize(Object.aes256cbc)
//                    try coder.serialize(Object.aes192cbc)
//                    try coder.serialize(Object.aes128cbc)
//                    try coder.serialize(Object.desede3cbc)
//                    try coder.serialize(ObjectInteger.rc2cbc80)
//                    try coder.serialize(ObjectInteger.rc2cbc40)
//                    try coder.serialize(Object.descbc)
//                    try coder.serialize(ObjectInteger.rc2cbc28)
//                }
//            }
//        }
//    }
//
//    struct Object: DERSerializable {
//        let oid: ASN1ObjectIdentifier
//
//        func serialize(into coder: inout DER.Serializer) throws {
//            try coder.appendConstructedNode(identifier: .sequence) { coder in
//                try coder.serialize(oid)
//            }
//        }
//
//        static let aes256cbc = Object(oid: .aes256cbc)
//        static let aes192cbc = Object(oid: .aes192cbc)
//        static let aes128cbc = Object(oid: .aes128cbc)
//        static let desede3cbc = Object(oid: .desede3cbc)
//        static let descbc = Object(oid: .descbc)
//    }
//
//    struct ObjectInteger: DERSerializable {
//        let oid: ASN1ObjectIdentifier
//        let int: [UInt8]
//
//        func serialize(into coder: inout DER.Serializer) throws {
//            try coder.appendConstructedNode(identifier: .sequence) { coder in
//                try coder.serialize(oid)
//                coder.appendPrimitiveNode(identifier: .integer) { bytes in
//                    bytes.append(contentsOf: int)
//                }
//            }
//        }
//
//        static let rc2cbc80 = ObjectInteger(oid: .rc2cbc, int: [0x00, 0x80])
//        static let rc2cbc40 = ObjectInteger(oid: .rc2cbc, int: [0x40])
//        static let rc2cbc28 = ObjectInteger(oid: .rc2cbc, int: [0x28])
//    }
// }
