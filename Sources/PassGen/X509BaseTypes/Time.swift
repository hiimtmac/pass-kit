// Time.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation
import SwiftASN1

// Time ::= CHOICE {
// utcTime        UTCTime,
// generalTime    GeneralizedTime }
@usableFromInline
enum Time: DERSerializable, Hashable, Sendable {
    case utcTime(UTCTime)
    case generalTime(GeneralizedTime)

    @inlinable
    func serialize(into coder: inout DER.Serializer) throws {
        switch self {
        case let .utcTime(utcTime):
            try coder.serialize(utcTime)
        case let .generalTime(generalizedTime):
            try coder.serialize(generalizedTime)
        }
    }

    @inlinable
    static func makeTime(from date: Date) throws -> Time {
        let components = date.utcDate

        // The rule is if the year is outside the range 1950-2049 inclusive, we should encode
        // it as a generalized time. Otherwise, use a UTCTime.
        guard (1950 ..< 2050).contains(components.year) else {
            let generalizedTime = try GeneralizedTime(components)
            return .generalTime(generalizedTime)
        }
        let utcTime = try UTCTime(components)
        return .utcTime(utcTime)
    }
}

extension Date {
    @inlinable
    var utcDate: (year: Int, month: Int, day: Int, hours: Int, minutes: Int, seconds: Int) {
        let timestamp = Int64(self.timeIntervalSince1970.rounded())
        return timestamp.utcDateFromTimestamp
    }
}

extension GeneralizedTime {
    @inlinable
    init(_ components: (year: Int, month: Int, day: Int, hours: Int, minutes: Int, seconds: Int)) throws {
        try self.init(
            year: components.year,
            month: components.month,
            day: components.day,
            hours: components.hours,
            minutes: components.minutes,
            seconds: components.seconds,
            fractionalSeconds: 0.0
        )
    }
}

extension UTCTime {
    @inlinable
    init(_ components: (year: Int, month: Int, day: Int, hours: Int, minutes: Int, seconds: Int)) throws {
        try self.init(
            year: components.year,
            month: components.month,
            day: components.day,
            hours: components.hours,
            minutes: components.minutes,
            seconds: components.seconds
        )
    }
}
