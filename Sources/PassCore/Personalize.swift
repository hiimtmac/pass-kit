// Personalize.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation

// https://developer.apple.com/documentation/walletpasses/personalize
/// An object that contains the personalization information for a rewards pass.
public struct Personalize: Codable, Equatable, Hashable {
    /// A brief description of the program for a pass that appears on the signup sheet, under the personalization logo.
    public var description: String

    /// An array that identifies the signup data required from the user the system shows on the generated signup form.
    public var requiredPersonalizationFields: [Fields]

    /// A description of the program’s terms and conditions. This string can contain HTML link tags to external content.
    ///
    /// If present, this information appears after the user enters their personal information and taps the Next button. The user then has the option to agree to the terms, or to cancel the sign-up process.
    public var termsAndConditions: String?

    public init(
        description: String,
        requiredPersonalizationFields: [Fields],
        termsAndConditions: String? = nil
    ) {
        self.description = description
        self.requiredPersonalizationFields = requiredPersonalizationFields
        self.termsAndConditions = termsAndConditions
    }
}

extension Personalize {
    public enum Fields: String, Codable, Equatable, Hashable, CaseIterable {
        case name = "PKPassPersonalizationFieldName"
        case postalCode = "PKPassPersonalizationFieldPostalCode"
        case emailAddress = "PKPassPersonalizationFieldEmailAddress"
        case phoneNumber = "PKPassPersonalizationFieldPhoneNumber"
    }
}
