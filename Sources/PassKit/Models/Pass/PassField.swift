// PassField.swift
// Copyright © 2022 hiimtmac

import Foundation

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/FieldDictionary.html#//apple_ref/doc/uid/TP40012026-CH4-SW5
/// Information about a field
public struct PassField: Codable {
    /// Attributed value of the field.
    /// The value may contain HTML markup for links. Only the <a> tag and its href attribute are supported.
    /// For example, the following is key-value pair specifies a link with the text “Edit my profile”: "attributedValue": "<a href='http://example.com/customers/123'>Edit my profile</a>"
    /// This key’s value overrides the text specified by the value key.
    /// Available in iOS 7.0.
    public var attributedValue: PassValue?
    /// Format string for the alert text that is displayed when the pass is updated. The format string must contain the escape %@, which is replaced with the field’s new value. For example, “Gate changed to %@.”
    /// If you don’t specify a change message, the user isn’t notified when the field changes.
    public var changeMessage: String?
    /// Data detectors that are applied to the field’s value.
    /// The default value is all data detectors. Provide an empty array to use no data detectors.
    /// Data detectors are applied only to back fields.
    public var dataDetectorTypes: [PassDataDetectorType]?
    /// The key must be unique within the scope of the entire pass. For example, “departure-gate.”
    public var key: String
    /// Label text for the field.
    public var label: String?
    /// Alignment for the field’s contents.
    /// The default value is natural alignment, which aligns the text appropriately based on its script direction.
    /// This key is not allowed for primary fields or back fields.
    public var textAligment: PassTextAlignment?
    /// Value of the field, for example, 42.
    public var value: PassValue?

    /// Information about a field
    /// - Parameters:
    ///   - attributedValue: Attributed value of the field.
    ///   - changeMessage: Format string for the alert text that is displayed when the pass is updated
    ///   - dataDetectorTypes: Data detectors that are applied to the field’s value
    ///   - key: The key must be unique within the scope of the entire pass
    ///   - label: Label text for the field
    ///   - textAligment: Alignment for the field’s contents
    ///   - value: Value of the field
    public init(
        attributedValue: PassValue? = nil,
        changeMessage: String? = nil,
        dataDetectorTypes: [PassDataDetectorType]? = nil,
        key: String,
        label: String? = nil,
        textAligment: PassTextAlignment? = nil,
        value: PassValue? = nil
    ) {
        self.attributedValue = attributedValue
        self.changeMessage = changeMessage
        self.dataDetectorTypes = dataDetectorTypes
        self.key = key
        self.label = label
        self.textAligment = textAligment
        self.value = value
    }
}

extension PassField {
    public enum PassValue: Codable {
        case double(Double)
        case string(String)

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            do {
                self = try .double(container.decode(Double.self))
            } catch DecodingError.typeMismatch {
                do {
                    self = try .string(container.decode(String.self))
                } catch DecodingError.typeMismatch {
                    throw DecodingError.typeMismatch(PassValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
                }
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .double(double):
                try container.encode(double)
            case let .string(string):
                try container.encode(string)
            }
        }
    }
}

extension PassField {
    public enum PassDataDetectorType: String, Codable {
        case phoneNumber = "PKDataDetectorTypePhoneNumber"
        case link = "PKDataDetectorTypeLink"
        case address = "PKDataDetectorTypeAddress"
        case calendarEvent = "PKDataDetectorTypeCalendarEvent"
    }
}

extension PassField {
    public enum PassTextAlignment: String, Codable {
        case left = "PKTextAlignmentLeft"
        case center = "PKTextAlignmentCenter"
        case right = "PKTextAlignmentRight"
        case natural = "PKTextAlignmentNatural"
    }
}
