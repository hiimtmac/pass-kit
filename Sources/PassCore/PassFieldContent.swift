// PassFieldContent.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation

// https://developer.apple.com/documentation/walletpasses/passfieldcontent
/// An object that represents the information to display in a field on a pass.
public struct PassFieldContent: Codable, Equatable, Hashable, Sendable {
    /// The value of the field, including HTML markup for links.
    ///
    /// The only supported tag is the <a> tag and its href attribute. The value of this key overrides that of the value key.
    ///
    /// For example, the following is a key-value pair that specifies a link with the text “Edit my profile”:
    /// ```json
    /// "attributedValue": "<a href='http://example.com/customers/123'>Edit my profile</a>"
    /// ```
    ///
    /// The attributed value isn’t used for watchOS; use the value field instead.
    public var attributedValue: AttributedValue?

    /// A format string for the alert text to display when the pass updates.
    ///
    /// The format string needs to contain the escape %@, which the field’s new value replaces. For example, Gate changed to %@.
    ///
    /// You need to provide a value for the system to show a change notification.
    ///
    /// This field isn’t used for watchOS.
    public var changeMessage: String?

    /// The ISO 4217 currency code to use for the value of the field.
    public var currencyCode: String?

    /// The data detectors to apply to the value of a field on the back of the pass.
    ///
    /// The default is to apply all data detectors. To use no data detectors, specify an empty array.
    ///
    /// You don’t use data detectors for fields on the front of the pass.
    ///
    /// This field isn’t used for watchOS.
    public var dataDetectorTypes: [DataDetectorType]?

    /// The style of the date to display in the field.
    public var dateStyle: DateTimeStyle?

    /// A Boolean value that controls the time zone for the time and date to display in the field.
    ///
    /// The default value is `false`, which displays the time and date using the current device’s time zone.
    /// Otherwise, the time and date appear in the time zone associated with the date and time of value.
    ///
    /// This key doesn’t affect the pass relevance calculation.
    public var ignoresTimeZone: Bool?

    /// A Boolean value that controls whether the date appears as a relative date.
    ///
    /// The default value is `false`, which displays the date as an absolute date.
    ///
    /// This key doesn’t affect the pass relevance calculation.
    public var isRelative: Bool?

    /// The key must be unique within the scope of the entire pass. For example, “departure-gate.”
    public var key: String

    /// Label text for the field.
    public var label: String?

    /// The style of the number to display in the field.
    ///
    /// Formatter styles have the same meaning as the formats with corresponding names in ``NumberFormatter.Style``.
    public var numberStyle: NumberStyle?

    /// A number you use to add a row to the auxiliary field in an event ticket pass type.
    ///
    /// This key is invalid for other types of passes.
    ///
    /// Set the value to `1` to add an auxiliary row.
    ///
    /// Each row displays up to four fields.
    public var row: Row?

    /// An object that contains machine-readable metadata the system uses to offer a pass and suggest related actions.
    ///
    /// For example, setting Don’t Disturb mode for the duration of a movie.
    public var semantics: SemanticTags?

    /// The alignment for the content of a field.
    ///
    /// The default is `natural` alignment, which aligns the text based on its script direction.
    ///
    /// This key is invalid for primary and back fields.
    public var textAlignment: TextAlignment?

    /// The style of the time displayed in the field.
    public var timeStyle: DateTimeStyle?

    /// Value of the field, for example, 42.
    public var value: Value

    public init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Value,
        dateStyle: DateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: DateTimeStyle? = nil,
        currencyCode: String? = nil,
        numberStyle: NumberStyle? = nil,
        row: Row? = nil,
        semantics: SemanticTags? = nil
    ) {
        self.attributedValue = attributedValue
        self.changeMessage = changeMessage
        self.dataDetectorTypes = dataDetectorTypes
        self.key = key
        self.label = label
        self.textAlignment = textAligment
        self.value = value
        self.dateStyle = dateStyle
        self.ignoresTimeZone = ignoresTimeZone
        self.isRelative = isRelative
        self.timeStyle = timeStyle
        self.currencyCode = currencyCode
        self.numberStyle = numberStyle
        self.row = row
        self.semantics = semantics
    }
}

extension PassFieldContent {
    public enum Value: Codable, Equatable, Hashable, Sendable {
        case double(Double)
        case string(String)
        case date(Date)

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let double = try? container.decode(Double.self) {
                self = .double(double)
            } else if let date = try? container.decode(Date.self) {
                self = .date(date)
            } else if let string = try? container.decode(String.self) {
                self = .string(string)
            } else {
                throw DecodingError.typeMismatch(
                    Value.self,
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Encoded payload not of an expected type"
                    )
                )
            }
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .double(double):
                try container.encode(double)
            case let .date(date):
                try container.encode(date)
            case let .string(string):
                try container.encode(string)
            }
        }
    }

    public enum DataDetectorType: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case phoneNumber = "PKDataDetectorTypePhoneNumber"
        case link = "PKDataDetectorTypeLink"
        case address = "PKDataDetectorTypeAddress"
        case calendarEvent = "PKDataDetectorTypeCalendarEvent"
    }

    public enum TextAlignment: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case left = "PKTextAlignmentLeft"
        case center = "PKTextAlignmentCenter"
        case right = "PKTextAlignmentRight"
        case natural = "PKTextAlignmentNatural"
    }

    public enum DateTimeStyle: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case none = "PKDateStyleNone"
        case short = "PKDateStyleShort"
        case medium = "PKDateStyleMedium"
        case long = "PKDateStyleLong"
        case full = "PKDateStyleFull"
    }

    public enum NumberStyle: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case decimal = "PKNumberStyleDecimal"
        case percent = "PKNumberStylePercent"
        case scientific = "PKNumberStyleScientific"
        case spellOut = "PKNumberStyleSpellOut"
    }

    public enum Row: Int, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case zero
        case one
    }

    public struct AttributedValue: Codable, Equatable, Hashable, Sendable {
        public var href: URL
        public var display: String

        public init(href: URL, display: String) {
            self.href = href
            self.display = display
        }

        public init(from decoder: any Decoder) throws {
            let regex = #/<a href='(?<href>\S+)'>(?<display>.+)</a>/#
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            guard
                let match = string.wholeMatch(of: regex),
                let url = URL(string: String(match.output.href))
            else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Expecting format: <a href='some_url'>Display Format</a>"
                )
            }

            self.href = url
            self.display = String(match.output.display)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode("<a href='\(href)'>\(display)</a>")
        }
    }
}
