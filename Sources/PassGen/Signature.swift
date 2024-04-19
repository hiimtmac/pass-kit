// Signature.swift
// Copyright (c) 2024 hiimtmac inc.

import _CryptoExtras
import Crypto
import Foundation
import SwiftASN1
import X509

enum Signature {
    static func makeData(
        manifest: Data,
        cert: Data,
        wwdr: Data,
        key: Data
    ) throws -> Data {
        let digest = try generateDigest(from: manifest)
        let wwdr = try loadCertificate(from: wwdr)
        let cert = try loadCertificate(from: cert)
        let key = try loadPrivateKey(from: key)

        return try makeData(digest: digest, cert: cert, wwdr: wwdr, key: key)
    }

    static func makeData(
        digest: ArraySlice<UInt8>,
        cert: Certificate,
        wwdr: Certificate,
        key: _RSA.Signing.PrivateKey
    ) throws -> Data {
        let attibutes: [CMSAttribute] = [
            .contentType,
            .signingTime(),
            .messageDigest(signature: .init(contentBytes: digest))
        ]

        let attibutesSignature = try generateAttributesSignature(
            attibutes: attibutes,
            key: key
        )

        return try generateSignature(
            certificate: cert,
            wwdr: wwdr,
            signedAttrs: attibutes,
            signature: attibutesSignature
        )
    }

    static func loadCertificate(from data: Data) throws -> Certificate {
        let string = String(decoding: data, as: UTF8.self)
        return try Certificate(pemEncoded: string)
    }

    static func loadPrivateKey(from data: Data) throws -> _RSA.Signing.PrivateKey {
        let string = String(decoding: data, as: UTF8.self)
        return try _RSA.Signing.PrivateKey(pemRepresentation: string)
    }

    static func generateDigest(from data: Data) throws -> ArraySlice<UInt8> {
        let digest = SHA256.hash(data: data)
        return ArraySlice(digest)
    }

    static func generateAttributesSignature(
        attibutes: [CMSAttribute],
        key: _RSA.Signing.PrivateKey
    ) throws -> ASN1OctetString {
        var serializer = DER.Serializer()
        try serializer.serializeSetOf(attibutes)
        let signature = try key.signature(
            for: serializer.serializedBytes,
            padding: .insecurePKCS1v1_5
        )
        let bytes = ArraySlice(signature.rawRepresentation)
        return ASN1OctetString(contentBytes: bytes)
    }

    static func generateSignature(
        certificate: Certificate,
        wwdr: Certificate,
        signedAttrs: [CMSAttribute],
        signature: ASN1OctetString
    ) throws -> Data {
        let signerInfo = CMSSignerInfo(
            version: .v1,
            signerIdentifier: .init(issuerAndSerialNumber: certificate),
            digestAlgorithm: .sha256,
            signedAttrs: signedAttrs,
            signatureAlgorithm: .rsaKey,
            signature: signature
        )

        let signedData = CMSSignedData(
            version: .v1,
            digestAlgorithms: [.sha256],
            encapContentInfo: .cmsData,
            certificates: [wwdr, certificate],
            signerInfos: [signerInfo]
        )

        let contentInfo = try CMSContentInfo(signedData)

        var serializer = DER.Serializer()
        try serializer.serialize(contentInfo)
        return Data(serializer.serializedBytes)
    }
}
