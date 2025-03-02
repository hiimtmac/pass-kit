// TimeCalculations.swift
// Copyright (c) 2025 hiimtmac inc.

extension Int64 {
    // 2000-03-01 (mod 400 year, immediately after feb29
    @inlinable
    static var leapoch: Int64 {
        .secondsFromEpochToYear2000 + .secondsPerDay * (31 + 29)
    }

    @inlinable
    static var secondsFromEpochToYear2000: Int64 {
        946_684_800
    }

    @inlinable
    static var daysPer400Years: Int64 {
        365 * 400 + 97
    }

    @inlinable
    static var daysPer100Years: Int64 {
        365 * 100 + 24
    }

    @inlinable
    static var daysPer4Years: Int64 {
        365 * 4 + 1
    }

    @inlinable
    static var secondsPerDay: Int64 {
        24 * 60 * 60
    }

    @inlinable
    static var secondsPerYear: Int64 {
        .secondsPerDay * .daysPerYear
    }

    @inlinable
    static var daysPerYear: Int64 {
        365
    }

    @inlinable
    static func daysInMonth(_ month: Int) -> Int64 {
        // This may seem weird, but these months are indexed from _March_.
        // Thus, month 0 is March, month 11 is February.
        switch month {
        case 0, 2, 4, 5, 7, 9, 10:
            31
        case 1, 3, 6, 8:
            30
        case 11:
            29
        default:
            fatalError()
        }
    }

    @inlinable
    var utcDateFromTimestamp: (year: Int, month: Int, day: Int, hours: Int, minutes: Int, seconds: Int) {
        let secs = self - .leapoch
        var (days, remsecs) = secs.quotientAndRemainder(dividingBy: 86400)

        // Tolerate negative values
        if remsecs < 0 {
            // Unchecked is safe here: we know remsecs is negative, and we know
            // days cannot be Int64.min
            remsecs &+= .secondsPerDay
            days &-= 1
        }

        var (qcCycles, remdays) = days.quotientAndRemainder(dividingBy: .daysPer400Years)
        if remdays < 0 {
            // Same justification here for unchecked arithmetic
            remdays &+= .daysPer400Years
            qcCycles &-= 1
        }

        // Unchecked arithmetic here is safe: the subtraction is all known values (4 - 1),
        // and the multiplication cannot exceed the original value of remdays.
        var cCycles = remdays / .daysPer100Years
        if cCycles == 4 { cCycles &-= 1 }
        remdays &-= cCycles &* .daysPer100Years

        // Unchecked arithmetic here is safe: the subtraction is all known values (25 - 1),
        // and the multiplication cannot exceed the original value of remdays.
        var qCycles = remdays / .daysPer4Years
        if qCycles == 25 { qCycles &-= 1 }
        remdays &-= qCycles &* .daysPer4Years

        // Unchecked arithmetic here is safe: the subtraction is all known values (4 - 1),
        // and the multiplication cannot exceed the original value of remdays.
        var remyears = remdays / .daysPerYear
        if remyears == 4 { remyears &-= 1 }
        remdays &-= remyears &* .daysPerYear

        // Unchecked multiplication here is safe: each of these has earlier been multiplied by
        // a much larger number and we didn't need checked math then, so we don't need it now.
        var years = remyears + (4 &* qCycles) + (100 &* cCycles) + (400 &* qcCycles)

        var months = 0
        while Int64.daysInMonth(months) <= remdays {
            remdays -= Int64.daysInMonth(months)

            // Unchecked because daysInMonth will crash if given a value greater than 12, so this
            // cannot exceed 12.
            months &+= 1
        }

        // Now we normalise the months count back to starting in January.
        // Safe to do unchecked subtraction here because for all numbers 10 or
        // larger we can subtract by 12.
        if months >= 10 {
            months &-= 12
            years += 1
        }

        // Normalise out the values.
        //
        // Safe to do unchecked math on the months as we just checked its value above.
        // Same for remdays, the loop only terminates if the number is smaller than at most 31.
        //
        // Note that, unlike struct tm, we return ordinal month numbers as well as days (i.e. 1 to 12).
        // This fits us better when working with GeneralizedTime and friends.
        return (
            year: Int(years + 2000),
            month: Int(months &+ 3),
            day: Int(remdays &+ 1),
            hours: Int(remsecs / 3600),
            minutes: Int(remsecs / 60 % 60),
            seconds: Int(remsecs % 60)
        )
    }
}
