// PreferredStyleScheme.swift
// Copyright (c) 2025 hiimtmac inc.

extension Pass {
    public enum PreferredStyleScheme: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case posterEventTicket
        case eventTicket
        case semanticBoardingPass
        case boardingPass
    }
}
