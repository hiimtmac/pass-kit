// PassFieldContent+Extensions.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation
import PassCore

// MARK: - String

extension PassFieldContent {
    init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: String,
        row: Row? = nil,
        semantics: SemanticTags? = nil
    ) {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            textAligment: textAligment,
            value: .string(value),
            row: row,
            semantics: semantics
        )
    }

    public static func primary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        value: String,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            value: value,
            semantics: semantics
        )
    }

    public static func secondary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: String,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            semantics: semantics
        )
    }

    public static func auxiliary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: String,
        row: Row? = nil,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            row: row,
            semantics: semantics
        )
    }

    public static func header(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: String,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            semantics: semantics
        )
    }

    public static func back(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        value: String,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            value: value,
            semantics: semantics
        )
    }
}

// MARK: - Double

extension PassFieldContent {
    init(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Double,
        style: NumberStyleType? = nil,
        row: Row? = nil,
        semantics: SemanticTags? = nil
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
            row: row,
            semantics: semantics
        )
    }

    public static func primary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        value: Double,
        style: NumberStyleType? = nil,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            value: value,
            style: style,
            semantics: semantics
        )
    }

    public static func secondary(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Double,
        style: NumberStyleType? = nil,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            style: style,
            semantics: semantics
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
        row: Row? = nil,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            style: style,
            row: row,
            semantics: semantics
        )
    }

    public static func header(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        key: String,
        label: String? = nil,
        textAligment: TextAlignment? = nil,
        value: Double,
        style: NumberStyleType? = nil,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            key: key,
            label: label,
            textAligment: textAligment,
            value: value,
            style: style,
            semantics: semantics
        )
    }

    public static func back(
        attributedValue: AttributedValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [DataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        value: Double,
        style: NumberStyleType? = nil,
        semantics: SemanticTags? = nil
    ) -> Self {
        self.init(
            attributedValue: attributedValue,
            changeMessage: changeMessage,
            dataDetectorTypes: dataDetectorTypes,
            key: key,
            label: label,
            value: value,
            style: style,
            semantics: semantics
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
    init(
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
        row: Row? = nil,
        semantics: SemanticTags? = nil
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
            row: row,
            semantics: semantics
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
        timeStyle: DateTimeStyle? = nil,
        semantics: SemanticTags? = nil
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
            timeStyle: timeStyle,
            semantics: semantics
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
        timeStyle: DateTimeStyle? = nil,
        semantics: SemanticTags? = nil
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
            semantics: semantics
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
        row: Row? = nil,
        semantics: SemanticTags? = nil
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
            row: row,
            semantics: semantics
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
        timeStyle: DateTimeStyle? = nil,
        semantics: SemanticTags? = nil
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
            semantics: semantics
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
        timeStyle: DateTimeStyle? = nil,
        semantics: SemanticTags? = nil
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
            timeStyle: timeStyle,
            semantics: semantics
        )
    }
}
