// AlgorithmIdentifier.swift
// Copyright (c) 2024 hiimtmac inc.

import SwiftASN1

extension ASN1ObjectIdentifier.AlgorithmIdentifier {
    static let sha256: ASN1ObjectIdentifier = [2, 16, 840, 1, 101, 3, 4, 2, 1]
}

@usableFromInline
struct AlgorithmIdentifier: DERSerializable, Hashable, Sendable {
    @usableFromInline
    var algorithm: ASN1ObjectIdentifier

    @usableFromInline
    var parameters: ASN1Any?

    @inlinable
    init(algorithm: ASN1ObjectIdentifier, parameters: ASN1Any?) {
        self.algorithm = algorithm
        self.parameters = parameters
    }

    @inlinable
    func serialize(into coder: inout DER.Serializer) throws {
        try coder.appendConstructedNode(identifier: .sequence) { coder in
            try coder.serialize(self.algorithm)
            if let parameters = self.parameters {
                try coder.serialize(parameters)
            }
        }
    }
}

extension AlgorithmIdentifier {
    @usableFromInline
    static let sha256 = AlgorithmIdentifier(
        algorithm: .AlgorithmIdentifier.sha256,
        parameters: try! ASN1Any(erasing: ASN1Null())
    )

    @usableFromInline
    static let rsaKey = AlgorithmIdentifier(
        algorithm: .AlgorithmIdentifier.rsaEncryption,
        parameters: try! ASN1Any(erasing: ASN1Null())
    )
}
