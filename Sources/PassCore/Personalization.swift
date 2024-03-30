//
//  File.swift
//  
//
//  Created by Taylor McIntyre on 2024-03-29.
//

import Foundation

// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/PassPersonalization.html#//apple_ref/doc/uid/TP40012195-CH12-SW2

public struct Personalization: Codable, Equatable, Hashable, Sendable {
    /// The contents of this array define the data requested from the user. The signup form’s fields are generated based on these keys.
    public var requiredPersonalizationFields: [Field]

    /// A brief description of the program. This is displayed on the signup sheet, under the personalization logo.
    public var description: String

    /// A description of the program’s terms and conditions. This string can contain HTML link tags to external content.
    ///
    /// If present, this information is displayed after the user enters their personal information and taps the Next button. 
    /// The user then has the option to agree to the terms, or to cancel out of the signup process.
    public var termsAndConditions: String?
    
    public init(
        requiredPersonalizationFields: [Field],
        description: String,
        termsAndConditions: String? = nil
    ) {
        self.requiredPersonalizationFields = requiredPersonalizationFields
        self.description = description
        self.termsAndConditions = termsAndConditions
    }
}

extension Personalization {
    public enum Field: String, Codable, Equatable, Hashable, Sendable {
        /// Prompts the user for their name. fullName, givenName, and familyName are submitted in the personalize request.
        case name = "PKPassPersonalizationFieldName"
        /// Prompts the user for their postal code. postalCode and ISOCountryCode are submitted in the personalize request.
        case postalCode = "PKPassPersonalizationFieldPostalCode"
        /// Prompts the user for their email address. emailAddress is submitted in the personalize request.
        case emailAddress = "PKPassPersonalizationFieldEmailAddress"
        /// Prompts the user for their phone number. phoneNumber is submitted in the personalize request.
        case phoneNumber = "PKPassPersonalizationFieldPhoneNumber"
    }
}
