// CMSVersion.swift
// Copyright (c) 2024 hiimtmac inc.

import SwiftASN1

/// ``CMPVersion`` is defined in ASN1. as:
/// ```
///  CMSVersion ::= INTEGER
///                 { v0(0), v1(1), v2(2), v3(3), v4(4), v5(5) }
/// ```
@usableFromInline
struct CMSVersion: RawRepresentable, Hashable, Sendable {
    @usableFromInline
    var rawValue: Int

    @inlinable
    init(rawValue: Int) {
        self.rawValue = rawValue
    }

    @usableFromInline
    static let v1 = Self(rawValue: 1)
}
