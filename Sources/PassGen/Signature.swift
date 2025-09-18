// Signature.swift
// Copyright (c) 2025 hiimtmac inc.

import _CryptoExtras
import Crypto
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif
@_spi(CMS) import X509

enum Signature {
    static func makeData(
        manifest: Data,
        cert: Certificate,
        wwdr: Certificate,
        key: _RSA.Signing.PrivateKey
    ) throws -> Data {
        let signature = try CMS.sign(
            manifest,
            signatureAlgorithm: .sha256WithRSAEncryption,
            additionalIntermediateCertificates: [wwdr],
            certificate: cert,
            privateKey: Certificate.PrivateKey(pemEncoded: key.pemRepresentation),
            signingTime: Date(),
            detached: true
        )

        return Data(signature)
    }
}
