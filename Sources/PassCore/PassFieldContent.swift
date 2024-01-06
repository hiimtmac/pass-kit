// PassFieldContent.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation

// https://developer.apple.com/documentation/walletpasses/passfieldcontent
/// An object that represents the information to display in a field on a pass.
public struct PassFieldContent: Codable, Equatable, Hashable {
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
    public var dataDetectorTypes: [DataDetectorType]?

    /// The key must be unique within the scope of the entire pass. For example, “departure-gate.”
    public var key: String

    /// Label text for the field.
    public var label: String?

    /// Alignment for the field’s contents.
    /// The default value is natural alignment, which aligns the text appropriately based on its script direction.
    ///
    /// This key is not allowed for primary fields or back fields.
    public var textAlignment: TextAlignment?

    /// Value of the field, for example, 42.
    public var value: Value

    /// Style of date to display
    public var dateStyle: DateTimeStyle?

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
    public var timeStyle: DateTimeStyle?

    /// ISO 4217 currency code for the field’s value.
    ///
    /// This cannot be set if `numberStyle` is set
    public var currencyCode: String?

    /// Style of number to display.
    ///
    /// Number styles have the same meaning as the Cocoa number formatter styles with corresponding names. For more information, see NSNumberFormatterStyle.
    /// This cannot be set if `currencyCode` is set
    public var numberStyle: NumberStyle?

    /// A number you use to add a row to the auxiliary field in an event ticket pass type. Set the value to 1 to add an auxiliary row. Each row displays up to four fields.
    public var row: Row?

    /// Prefer conveniences over this initializer
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
        row: Row? = nil
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
    }
}

extension PassFieldContent {
    public enum Value: Codable, Equatable, Hashable {
        case double(Double)
        case string(String)
        case date(Date)

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let double = try? container.decode(Double.self) {
                self = .double(double)
            } else if let string = try? container.decode(String.self) {
                if let date = Value.dateFormatter.date(from: string) {
                    self = .date(date)
                } else {
                    self = .string(string)
                }
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

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .double(double):
                try container.encode(double)
            case let .date(date):
                let string = Value.dateFormatter.string(from: date)
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

    public enum DataDetectorType: String, Codable, Equatable, Hashable, CaseIterable {
        case phoneNumber = "PKDataDetectorTypePhoneNumber"
        case link = "PKDataDetectorTypeLink"
        case address = "PKDataDetectorTypeAddress"
        case calendarEvent = "PKDataDetectorTypeCalendarEvent"
    }

    public enum TextAlignment: String, Codable, Equatable, Hashable, CaseIterable {
        case left = "PKTextAlignmentLeft"
        case center = "PKTextAlignmentCenter"
        case right = "PKTextAlignmentRight"
        case natural = "PKTextAlignmentNatural"
    }

    public enum DateTimeStyle: String, Codable, Equatable, Hashable, CaseIterable {
        case none = "PKDateStyleNone"
        case short = "PKDateStyleShort"
        case medium = "PKDateStyleMedium"
        case long = "PKDateStyleLong"
        case full = "PKDateStyleFull"
    }

    public enum NumberStyle: String, Codable, Equatable, Hashable, CaseIterable {
        case decimal = "PKNumberStyleDecimal"
        case percent = "PKNumberStylePercent"
        case scientific = "PKNumberStyleScientific"
        case spellOut = "PKNumberStyleSpellOut"
    }

    public enum Row: Int, Codable, Equatable, Hashable, CaseIterable {
        case zero
        case one
    }
}

// MARK: - Conveniences

extension PassFieldContent {
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
}

// MARK: - String

extension PassFieldContent {
    /// Prefer conveniences over this initializer
    public init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: String,
        row: Row? = nil
    ) {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            textAligment: textAligment,
            value: .string(value),
            row: row
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

    public static func secondary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
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

    public static func auxiliary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: String,
        row: Row? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            row: row
        )
    }

    public static func header(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
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
        dataDetectorTypes: [DataDetectorType]? = nil,
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
}

// MARK: - Double

extension PassFieldContent {
    /// Prefer conveniences over this initializer
    public init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Double,
        style: NumberStyleType? = nil,
        row: Row? = nil
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
            numberStyle: style?.numberStyle,
            row: row
        )
    }

    public static func primary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        value: Double,
        style: NumberStyleType? = nil
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

    public static func secondary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Double,
        style: NumberStyleType? = nil
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

    public static func auxiliary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Double,
        style: NumberStyleType? = nil,
        row: Row? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            style: style,
            row: row
        )
    }

    public static func header(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Double,
        style: NumberStyleType? = nil
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
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        value: Double,
        style: NumberStyleType? = nil
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

    public enum NumberStyleType: Codable {
        case currencyCode(String)
        case numberStyle(NumberStyle)

        var currencyCode: String? {
            switch self {
            case let .currencyCode(code): code
            case .numberStyle: nil
            }
        }

        var numberStyle: NumberStyle? {
            switch self {
            case .currencyCode: nil
            case let .numberStyle(style): style
            }
        }
    }
}

// MARK: - Date

extension PassFieldContent {
    /// Prefer conveniences over this initializer
    public init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Date,
        dateStyle: DateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: DateTimeStyle? = nil,
        row: Row? = nil
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
            timeStyle: timeStyle,
            row: row
        )
    }

    public static func primary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        value: Date,
        dateStyle: DateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: DateTimeStyle? = nil
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

    public static func secondary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Date,
        dateStyle: DateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: DateTimeStyle? = nil
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

    public static func auxiliary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Date,
        dateStyle: DateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: DateTimeStyle? = nil,
        row: Row? = nil
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
            timeStyle: timeStyle,
            row: row
        )
    }

    public static func header(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Date,
        dateStyle: DateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: DateTimeStyle? = nil
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
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        value: Date,
        dateStyle: DateTimeStyle? = nil,
        ignoresTimeZone: Bool? = nil,
        isRelative: Bool? = nil,
        timeStyle: DateTimeStyle? = nil
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