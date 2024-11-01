// PreferredStyleScheme.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation

extension Pass {
    public enum PreferredStyleScheme: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case posterEventTicket
        case eventTicket
    }
}
