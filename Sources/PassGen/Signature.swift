// Signature.swift
// Copyright (c) 2023 hiimtmac inc.

import _CryptoExtras
import Crypto
import Foundation
import SwiftASN1
import X509

class Signature {
    func makeData(manifest: Data, cert: URL, wwdr: URL, key: URL) throws -> Data {
        let digest = try generateDigest(from: manifest)
        let wwdr = try loadCertificate(from: wwdr)
        let cert = try loadCertificate(from: cert)
        let key = try loadPrivateKey(from: key)

        let authAttributes = AuthenticatedAttributes(messageDigest: digest)
        let encryptedDigest = try generateEncryptedDigest(authAttributes: authAttributes, key: key)

        return try generateSignature(
            certificate: cert,
            wwdr: wwdr,
            authAttributes: authAttributes,
            encryptedDigest: encryptedDigest
        )
    }

    private func loadCertificate(from url: URL) throws -> Certificate {
        let data = try Data(contentsOf: url)
        let string = String(decoding: data, as: UTF8.self)
        return try Certificate(pemEncoded: string)
    }

    private func loadPrivateKey(from url: URL) throws -> _RSA.Signing.PrivateKey {
        let data = try Data(contentsOf: url)
        let string = String(decoding: data, as: UTF8.self)
        return try _RSA.Signing.PrivateKey(pemRepresentation: string)
    }

    private func generateDigest(from data: Data) throws -> ArraySlice<UInt8> {
        let digest = SHA256.hash(data: data)
        return ArraySlice(digest)
    }

    func generateEncryptedDigest(
        authAttributes: AuthenticatedAttributes,
        key: _RSA.Signing.PrivateKey
    ) throws -> ArraySlice<UInt8> {
        var serializer = DER.Serializer()
        try serializer.appendConstructedNode(identifier: .set) { coder in
            try coder.serialize(authAttributes)
        }
        let signature = try key.signature(for: serializer.serializedBytes, padding: .insecurePKCS1v1_5)
        return ArraySlice(signature.rawRepresentation)
    }

    func generateSignature(
        certificate: Certificate,
        wwdr: Certificate,
        authAttributes: AuthenticatedAttributes,
        encryptedDigest: ArraySlice<UInt8>
    ) throws -> Data {
        var serializer = DER.Serializer()
        try serializer.serialize(CMSContentInfo(
            certificate: certificate,
            wwdr: wwdr,
            authenticatedAttributes: authAttributes,
            encryptedDigest: encryptedDigest
        ))
        return Data(serializer.serializedBytes)
    }
}
