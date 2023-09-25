// CMS.swift
// Copyright (c) 2023 hiimtmac inc.

import Foundation
import SwiftASN1
import X509

extension ASN1ObjectIdentifier {
    static let contentType: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 9, 3]
    static let pkcs7Data: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 7, 1]
    static let signingTime: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 9, 5]
    static let sha256: ASN1ObjectIdentifier = [2, 16, 840, 1, 101, 3, 4, 2, 1]
    static let rsaEncryption: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 1, 1]
    static let cmsData: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 7, 1]
    static let cmsSignedData: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 7, 2]
    static let messageDigest: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 9, 4]
    static let smimeCapabilities: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 1, 9, 15]
    static let aes256cbc: ASN1ObjectIdentifier = [2, 16, 840, 1, 101, 3, 4, 1, 42]
    static let aes192cbc: ASN1ObjectIdentifier = [2, 16, 840, 1, 101, 3, 4, 1, 22]
    static let aes128cbc: ASN1ObjectIdentifier = [2, 16, 840, 1, 101, 3, 4, 1, 2]
    static let desede3cbc: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 3, 7]
    static let rc2cbc: ASN1ObjectIdentifier = [1, 2, 840, 113_549, 3, 2]
    static let descbc: ASN1ObjectIdentifier = [1, 3, 14, 3, 2, 7]
}

struct CMSIssuerAndSerialNumber: DERSerializable {
    let issuer: DistinguishedName
    let serialNumber: Certificate.SerialNumber

    init(
        certificate: Certificate
    ) {
        self.issuer = certificate.issuer
        self.serialNumber = certificate.serialNumber
    }

    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(self.issuer)
            try coder.serialize(self.serialNumber.bytes)
        }
    }
}

struct AuthenticatedAttributes: DERSerializable {
    let contentType: ContentTypeAttribute
    let signingTime: SigningTimeAttribute
    let messageDigest: MessageDigestAttribute
    let smimeCapabilities: SMIMECapabilitiesAttribute

    init(messageDigest: ArraySlice<UInt8>) {
        self.contentType = ContentTypeAttribute()
        self.signingTime = SigningTimeAttribute()
        self.messageDigest = MessageDigestAttribute(contentBytes: messageDigest)
        self.smimeCapabilities = SMIMECapabilitiesAttribute()
    }

    func serialize(into coder: inout DER.Serializer) throws {
        try coder.serialize(contentType)
        try coder.serialize(signingTime)
        try coder.serialize(messageDigest)
        try coder.serialize(smimeCapabilities)
    }

    struct ContentTypeAttribute: DERSerializable {
        let oid: ASN1ObjectIdentifier = .contentType

        func serialize(into coder: inout DER.Serializer) throws {
            try coder.appendConstructedNode(identifier: .sequence) { coder in
                try coder.serialize(self.oid)
                try coder.serializeSetOf([
                    ASN1Any(erasing: ASN1ObjectIdentifier.pkcs7Data)
                ])
            }
        }
    }

    struct SigningTimeAttribute: DERSerializable {
        let oid: ASN1ObjectIdentifier = .signingTime
        let date: Date

        init(date: Date = .now) {
            self.date = date
        }

        func serialize(into coder: inout DER.Serializer) throws {
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(identifier: "UTC")!

            let utc = try UTCTime(
                year: calendar.component(.year, from: date),
                month: calendar.component(.month, from: date),
                day: calendar.component(.day, from: date),
                hours: calendar.component(.hour, from: date),
                minutes: calendar.component(.minute, from: date),
                seconds: calendar.component(.second, from: date)
            )

            try coder.appendConstructedNode(identifier: .sequence) { coder in
                try coder.serialize(self.oid)
                try coder.serializeSetOf([
                    ASN1Any(erasing: utc)
                ])
            }
        }
    }

    struct MessageDigestAttribute: DERSerializable {
        let oid: ASN1ObjectIdentifier = .messageDigest
        let contentBytes: ArraySlice<UInt8>

        func serialize(into coder: inout DER.Serializer) throws {
            let octetString = ASN1OctetString(contentBytes: contentBytes)

            try coder.appendConstructedNode(identifier: .sequence) { coder in
                try coder.serialize(self.oid)
                try coder.serializeSetOf([
                    ASN1Any(erasing: octetString)
                ])
            }
        }
    }

    struct SMIMECapabilitiesAttribute: DERSerializable {
        let oid: ASN1ObjectIdentifier = .smimeCapabilities

        func serialize(into coder: inout DER.Serializer) throws {
            try coder.appendConstructedNode(identifier: .sequence) { coder in
                try coder.serialize(self.oid)
                try coder.appendConstructedNode(identifier: .set) { coder in
                    try coder.appendConstructedNode(identifier: .sequence) { coder in
                        try coder.serialize(Object.aes256cbc)
                        try coder.serialize(Object.aes192cbc)
                        try coder.serialize(Object.aes128cbc)
                        try coder.serialize(Object.desede3cbc)
                        try coder.serialize(ObjectInteger.rc2cbc80)
                        try coder.serialize(ObjectInteger.rc2cbc40)
                        try coder.serialize(Object.descbc)
                        try coder.serialize(ObjectInteger.rc2cbc28)
                    }
                }
            }
        }

        struct Object: DERSerializable {
            let oid: ASN1ObjectIdentifier

            func serialize(into coder: inout DER.Serializer) throws {
                try coder.appendConstructedNode(identifier: .sequence) { coder in
                    try coder.serialize(oid)
                }
            }

            static let aes256cbc = Object(oid: .aes256cbc)
            static let aes192cbc = Object(oid: .aes192cbc)
            static let aes128cbc = Object(oid: .aes128cbc)
            static let desede3cbc = Object(oid: .desede3cbc)
            static let descbc = Object(oid: .descbc)
        }

        struct ObjectInteger: DERSerializable {
            let oid: ASN1ObjectIdentifier
            let int: [UInt8]

            func serialize(into coder: inout DER.Serializer) throws {
                try coder.appendConstructedNode(identifier: .sequence) { coder in
                    try coder.serialize(oid)
                    coder.appendPrimitiveNode(identifier: .integer) { bytes in
                        bytes.append(contentsOf: int)
                    }
                }
            }

            static let rc2cbc80 = ObjectInteger(oid: .rc2cbc, int: [0x00, 0x80])
            static let rc2cbc40 = ObjectInteger(oid: .rc2cbc, int: [0x40])
            static let rc2cbc28 = ObjectInteger(oid: .rc2cbc, int: [0x28])
        }
    }
}

struct CMSSignerInfo: DERSerializable {
    let version: CMSVersion = .v1
    let signerIdentifier: CMSIssuerAndSerialNumber
    let digestAlgorithm: AlgorithmIdentifier = .sha256
    let signatureAlgorithm: AlgorithmIdentifier = .rsaEncryption
    let authenticatedAttributes: AuthenticatedAttributes
    let encryptedDigest: ArraySlice<UInt8>

    init(
        certificate: Certificate,
        authenticatedAttributes: AuthenticatedAttributes,
        encryptedDigest: ArraySlice<UInt8>
    ) {
        self.signerIdentifier = .init(certificate: certificate)
        self.authenticatedAttributes = authenticatedAttributes
        self.encryptedDigest = encryptedDigest
    }

    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(self.version.rawValue)
            try coder.serialize(self.signerIdentifier)
            try coder.serialize(self.digestAlgorithm)
            try coder.serialize(authenticatedAttributes, explicitlyTaggedWithTagNumber: 0, tagClass: .contextSpecific)
            try coder.serialize(self.signatureAlgorithm)
            try coder.serialize(ASN1OctetString(contentBytes: encryptedDigest))
        }
    }
}

struct AlgorithmIdentifier: DERSerializable {
    let oid: ASN1ObjectIdentifier

    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(self.oid)
            try coder.serialize(ASN1Any(erasing: ASN1Null()))
        }
    }

    static let sha256 = AlgorithmIdentifier(oid: .sha256)
    static let rsaEncryption = AlgorithmIdentifier(oid: .rsaEncryption)
}

struct CMSEncapsulatedContentInfo: DERSerializable {
    let eContentType: ASN1ObjectIdentifier = .cmsData

    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(eContentType)
        }
    }

    static let cmsData = CMSEncapsulatedContentInfo()
}

struct CMSVersion: RawRepresentable {
    var rawValue: Int
    static let v1 = Self(rawValue: 1)
}

struct CMSSignedData: DERSerializable {
    let version: CMSVersion = .v1
    let digestAlgorithms: [AlgorithmIdentifier] = [.sha256]
    let encapContentInfo: CMSEncapsulatedContentInfo = .cmsData
    let certificates: [Certificate]
    let signerInfos: [CMSSignerInfo]

    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(self.version.rawValue)
            try coder.serializeSetOf(self.digestAlgorithms)
            try coder.serialize(self.encapContentInfo)
            try coder.serializeSetOf(self.certificates, identifier: .init(tagWithNumber: 0, tagClass: .contextSpecific))
            try coder.serializeSetOf(self.signerInfos, identifier: .set)
        }
    }
}

struct CMSContentInfo: DERSerializable {
    let contentType: ASN1ObjectIdentifier = .cmsSignedData
    let signedData: CMSSignedData

    init(
        certificate: Certificate,
        wwdr: Certificate,
        authenticatedAttributes: AuthenticatedAttributes,
        encryptedDigest: ArraySlice<UInt8>
    ) {
        let signerInfo = CMSSignerInfo(
            certificate: certificate,
            authenticatedAttributes: authenticatedAttributes,
            encryptedDigest: encryptedDigest
        )

        self.signedData = .init(
            certificates: [wwdr, certificate],
            signerInfos: [signerInfo]
        )
    }

    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(contentType)
            try coder.serialize(explicitlyTaggedWithTagNumber: 0, tagClass: .contextSpecific) { coder in
                try coder.serialize(ASN1Any(erasing: signedData))
            }
        }
    }
}
