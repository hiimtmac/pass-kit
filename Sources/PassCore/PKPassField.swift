// PKPassField.swift
// Copyright (c) 2023 hiimtmac inc.

import Foundation

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/FieldDictionary.html#//apple_ref/doc/uid/TP40012026-CH4-SW5
/// Information about a field
public struct PKPassField: Codable, Equatable, Hashable {
    /// Attributed value of the field.
    /// The value may contain HTML markup for links. Only the <a> tag and its href attribute are supported.
    /// For example, the following is key-value pair specifies a link with the text “Edit my profile”: "attributedValue": "<a href='http://example.com/customers/123'>Edit my profile</a>"
    ///
    /// This key’s value overrides the text specified by the value key.
    public var attributedValue: AttributedValue?
    /// Format string for the alert text that is displayed when the pass is updated. The format string must contain the escape %@, which is replaced with the field’s new value. For example, “Gate changed to %@.”
    ///
    /// If you don’t specify a change message, the user isn’t notified when the field changes.
    public var changeMessage: String?
    /// Data detectors that are applied to the field’s value.
    /// The default value is all data detectors. Provide an empty array to use no data detectors.
    ///
    /// Data detectors are applied only to back fields.
    public var dataDetectorTypes: [PKPassDataDetectorType]?
    /// The key must be unique within the scope of the entire pass. For example, “departure-gate.”
    public var key: String
    /// Label text for the field.
    public var label: String?
    /// Alignment for the field’s contents.
    /// The default value is natural alignment, which aligns the text appropriately based on its script direction.
    ///
    /// This key is not allowed for primary fields or back fields.
    public var textAlignment: PKPassTextAlignment?
    /// Value of the field, for example, 42.
    public var value: PKPassValue
    /// Style of date to display
    public var dateStyle: PKPassDateTimeStyle?
    /// Always display the time and date in the given time zone, not in the user’s current time zone. The default value is false.
    /// The format for a date and time always requires a time zone, even if it will be ignored.
    /// For backward compatibility with iOS 6, provide an appropriate time zone, so that the information is displayed meaningfully even without ignoring time zones.
    ///
    /// This key does not affect how relevance is calculated.
    public var ignoresTimeZone: Bool?
    /// If true, the label’s value is displayed as a relative date; otherwise, it is displayed as an absolute date.
    /// The default value is false.
    ///
    /// This key does not affect how relevance is calculated.
    public var isRelative: Bool?
    /// Style of time to display
    public var timeStyle: PKPassDateTimeStyle?
    /// ISO 4217 currency code for the field’s value.
    ///
    /// This cannot be set if `numberStyle` is
    public var currencyCode: String?
    /// Style of number to display.
    ///
    /// Number styles have the same meaning as the Cocoa number formatter styles with corresponding names. For more information, see NSNumberFormatterStyle.
    /// This cannot be set if `currencyCode` is
    public var numberStyle: PKPassNumberStyle?

    /// Warning: Do not use this directly
    public init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [PKPassDataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: PKPassTextAlignment? = nil,
        value: PKPassValue,
        dateStyle: PKPassDateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: PKPassDateTimeStyle? = nil,
        currencyCode: String? = nil,
        numberStyle: PKPassNumberStyle? = nil
    ) {
        self.attributedValue = attributedValue
        self.changeMessage = changeMessage
        self.dataDetectorTypes = dataDetectorTypes
        self.key = key
        self.label = label
        self.textAlignment = textAligment
        self.value = value
    }
}

extension PKPassField {
    public enum PKPassValue: Codable, Equatable, Hashable {
        case double(Double)
        case string(String)
        case date(Date)

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let double = try? container.decode(Double.self) {
                self = .double(double)
            } else if let string = try? container.decode(String.self) {
                if let date = PKPassValue.dateFormatter.date(from: string) {
                    self = .date(date)
                } else {
                    self = .string(string)
                }
            } else {
                throw DecodingError.typeMismatch(
                    PKPassValue.self,
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Encoded payload not of an expected type"
                    )
                )
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .double(double):
                try container.encode(double)
            case let .date(date):
                let string = PKPassValue.dateFormatter.string(from: date)
                try container.encode(string)
            case let .string(string):
                try container.encode(string)
            }
        }

        public static let dateFormatter: ISO8601DateFormatter = {
            let formatter = ISO8601DateFormatter()
            return formatter
        }()
    }

    public enum PKPassDataDetectorType: String, Codable, Equatable, Hashable, CaseIterable {
        case phoneNumber = "PKDataDetectorTypePhoneNumber"
        case link = "PKDataDetectorTypeLink"
        case address = "PKDataDetectorTypeAddress"
        case calendarEvent = "PKDataDetectorTypeCalendarEvent"
    }

    public enum PKPassTextAlignment: String, Codable, Equatable, Hashable, CaseIterable {
        case left = "PKTextAlignmentLeft"
        case center = "PKTextAlignmentCenter"
        case right = "PKTextAlignmentRight"
        case natural = "PKTextAlignmentNatural"
    }

    public enum PKPassDateTimeStyle: String, Codable, Equatable, Hashable, CaseIterable {
        case none = "PKDateStyleNone"
        case short = "PKDateStyleShort"
        case medium = "PKDateStyleMedium"
        case long = "PKDateStyleLong"
        case full = "PKDateStyleFull"
    }

    public enum PKPassNumberStyle: String, Codable, Equatable, Hashable, CaseIterable {
        case decimal = "PKNumberStyleDecimal"
        case percent = "PKNumberStylePercent"
        case scientific = "PKNumberStyleScientific"
        case spellOut = "PKNumberStyleSpellOut"
    }
}

// MARK: - Conveniences

extension PKPassField {
    public struct AttributedValue: Codable, Equatable, Hashable {
        public var href: URL
        public var display: String

        public init(href: URL, display: String) {
            self.href = href
            self.display = display
        }

        public init(from decoder: Decoder) throws {
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

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode("<a href='\(href)'>\(display)</a>")
        }
    }

    // MARK: String

    /// Warning: Do not use this directly
    public init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [PKPassDataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: PKPassTextAlignment? = nil,
        value: String
    ) {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            textAligment: textAligment,
            value: .string(value)
        )
    }

    public static func primary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        value: String
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            value: value
        )
    }

    public static func secondaryAuxiliaryHeader(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: PKPassTextAlignment? = nil,
        value: String
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value
        )
    }

    public static func back(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [PKPassDataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        value: String
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            value: value
        )
    }

    // MARK: Double

    /// Warning: Do not use this directly
    public init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [PKPassDataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: PKPassTextAlignment? = nil,
        value: Double,
        style: NumberStyle? = nil
    ) {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            textAligment: textAligment,
            value: .double(value),
            currencyCode: style?.currencyCode,
            numberStyle: style?.numberStyle
        )
    }

    public static func primary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        value: Double,
        style: NumberStyle? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            value: value,
            style: style
        )
    }

    public static func secondaryAuxiliaryHeader(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: PKPassTextAlignment? = nil,
        value: Double,
        style: NumberStyle? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            style: style
        )
    }

    public static func back(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [PKPassDataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        value: Double,
        style: NumberStyle? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            value: value,
            style: style
        )
    }

    public enum NumberStyle: Codable {
        case currencyCode(String)
        case numberStyle(PKPassNumberStyle)

        var currencyCode: String? {
            switch self {
            case let .currencyCode(code): return code
            case .numberStyle: return nil
            }
        }

        var numberStyle: PKPassNumberStyle? {
            switch self {
            case .currencyCode: return nil
            case let .numberStyle(style): return style
            }
        }
    }

    // MARK: Date

    /// Warning: Do not use this directly
    public init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [PKPassDataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: PKPassTextAlignment? = nil,
        value: Date,
        dateStyle: PKPassDateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: PKPassDateTimeStyle? = nil
    ) {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            textAligment: textAligment,
            value: .date(value),
            dateStyle: dateStyle,
            ignoresTimeZone: ignoresTimeZone,
            isRelative: isRelative,
            timeStyle: timeStyle
        )
    }

    public static func primary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        value: Date,
        dateStyle: PKPassDateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: PKPassDateTimeStyle? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            value: value,
            dateStyle: dateStyle,
            ignoresTimeZone: ignoresTimeZone,
            isRelative: isRelative,
            timeStyle: timeStyle
        )
    }

    public static func secondaryAuxiliaryHeader(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: PKPassTextAlignment? = nil,
        value: Date,
        dateStyle: PKPassDateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: PKPassDateTimeStyle? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            dateStyle: dateStyle,
            ignoresTimeZone: ignoresTimeZone,
            isRelative: isRelative,
            timeStyle: timeStyle
        )
    }

    public static func back(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [PKPassDataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        value: Date,
        dateStyle: PKPassDateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: PKPassDateTimeStyle? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            value: value,
            dateStyle: dateStyle,
            ignoresTimeZone: ignoresTimeZone,
            isRelative: isRelative,
            timeStyle: timeStyle
        )
    }
}
