// SignerTests.swift
// Copyright (c) 2025 hiimtmac inc.

import SwiftASN1
import XCTest
@testable import PassGen

final class SignerTests: XCTestCase {
    var wwdr: Data!
    var cert: Data!
    var key: Data!

    override func setUp() async throws {
        try await super.setUp()

        let wwdrUrl = Bundle.module.url(forResource: "wwdr", withExtension: "pem")!
        wwdr = try Data(contentsOf: wwdrUrl)

        let certUrl = Bundle.module.url(forResource: "cert", withExtension: "pem")!
        cert = try Data(contentsOf: certUrl)

        let keyUrl = Bundle.module.url(forResource: "key", withExtension: "pem")!
        key = try Data(contentsOf: keyUrl)
    }

//    func testDigestMatchesOpenssl() throws {
//        // echo -n "hello" | openssl dgst -sha256 | awk '{print $2}' | xxd -r -p | od -An -t u1
//        let hash: ArraySlice<UInt8> = [44, 242, 77, 186, 95, 176, 163, 14, 38, 232, 59, 42, 197, 185, 226, 158, 27, 22, 30, 92, 31, 167, 66, 94, 115, 4, 51, 98, 147, 139, 152, 36]
//        let digest = try Signature.generateDigest(from: Data("hello".utf8))
//        XCTAssertEqual(hash, digest)
//    }

//    func testSignatureGenerationMatchesOpenssl() throws {
    ////        var serializer = DER.Serializer()
    ////        try serializer.serializeSetOf([CMSAttribute.contentType])
    ////        let bytes = ArraySlice(serializer.serializedBytes)
    ////        let hexString = bytes.map { String(format: "%02x", $0) }.joined()
    ////        echo hexString | xxd -r -p | openssl dgst -sha256 -sign key.pem | xxd -p
//
//        let openssl = """
//            18dbaa1495b4437f5b2d32451aa74f7209e8a1c2091eb60368a74b57aab3
//            6e2a2e90058c92dbdf49cad3313d7b6ccfc869b39d7fbbd476ef9811613a
//            1c53525e00b94f4ad825cb9fc0c9752a970a5eca74a626ab0bcfd4478e9d
//            86ae3d11f95331e8fdf2ed22f839a251dc0df852a965b4c57a4a3011f365
//            88cf32d9970d1df00653c95212b1d34a1d596791a38c597db9351f3b94e6
//            b92f314f59f47f56ac3deaf1cfa86a19c194a4bc7de238e4aedcb32e7888
//            aa7e55f333a2b2188652302b7adbcb9e1e6a7115c2b8dfe78391f0927d35
//            cec10d5271661adfa13aa73ff7a5f97331d795466706c69355e992d5bb61
//            7cdafe179fedf06b7a996f68c9e3a478
//            """
//
//        let key = try Signature.loadPrivateKey(from: key)
//        let signature = try Signature.generateAttributesSignature(
//            attibutes: [.contentType],
//            key: key
//        )
//
//        let opensslSingle = openssl.components(separatedBy: "\n").joined()
//        let hexedSignature = signature.bytes.map { String(format: "%02x", $0) }.joined()
//        XCTAssertEqual(hexedSignature, opensslSingle)
//    }
}
