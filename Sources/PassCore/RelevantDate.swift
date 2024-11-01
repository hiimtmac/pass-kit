// RelevantDate.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation

extension Pass {
    public struct RelevantDate: Codable, Equatable, Hashable, Sendable {
        public var startDate: Date
        public var endDate: Date

        public init(
            startDate: Date,
            endDate: Date
        ) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }
}
