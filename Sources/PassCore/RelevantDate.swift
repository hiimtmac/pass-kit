// RelevantDate.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation

extension Pass {
    /// https://developer.apple.com/documentation/walletpasses/pass/relevantdates-data.dictionary
    public struct RelevantDates: Codable, Equatable, Hashable, Sendable {
        /// The date and time when the pass becomes relevant.
        public var date: Date?

        /// The date and time for the pass relevancy interval to end.
        ///
        /// Required when providing ``startDate``.
        public var endDate: Date?

        /// The date and time for the pass relevancy interval to begin
        public var startDate: Date?

        public init(
            date: Date? = nil,
            startDate: Date? = nil,
            endDate: Date? = nil
        ) {
            self.date = date
            self.startDate = startDate
            self.endDate = endDate
        }
    }
}
