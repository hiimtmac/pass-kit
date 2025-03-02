// PassFields.swift
// Copyright (c) 2025 hiimtmac inc.

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/LowerLevel.html#//apple_ref/doc/uid/TP40012026-CH3-SW14
/// These keys are used for all pass styles and partition the fields into the various parts of the pass
///
/// The pass style determines the maximum number of fields that can appear on the front of a pass:
///
/// - In general, a pass can have up to three header fields, a single primary field, up to four secondary fields, and up to four auxiliary fields.
/// - Boarding passes can have up to two primary fields and up to five auxiliary fields.
/// - Coupons, store cards, and generic passes with a square barcode can have a total of up to four secondary and auxiliary fields, combined.
///
/// The number of fields displayed on the pass also depends on the length of the text in each field. If there is too much text, some fields may not be displayed.
///
/// NOTE
/// Do not include more fields than are displayed on the front of your pass. Although additional fields may not be shown today, layouts may change in the future, and you would not want a previously hidden field to suddenly become visible to users.
///

// https://developer.apple.com/documentation/walletpasses/passfields
/// An object that represents the groups of fields that display information on the front and back of a pass.
public struct PassFields: Codable, Equatable, Hashable, Sendable {
    /// An object that represents fields that display in the Additional Info section below a pass.
    ///
    /// This key works only for poster event tickets.
    public var additionalInfoFields: [PassFieldContent]?

    /// An object that represents the fields that display additional information on the front of a pass.
    public var auxiliaryFields: [PassFieldContent]?

    /// An object that represents the fields that display information on the back of a pass.
    public var backFields: [PassFieldContent]?

    /// An object that represents the fields that display information at the top of a pass.
    public var headerFields: [PassFieldContent]?

    /// An object that represents the fields that display the most important information on a pass.
    public var primaryFields: [PassFieldContent]?

    /// An object that represents the fields that display supporting information on the front of a pass.
    public var secondaryFields: [PassFieldContent]?

    /// The type of transit for a boarding pass.
    ///
    /// This key is invalid for other types of passes.
    ///
    /// The system may use the value to display more information, such as showing an airplane icon for the pass on watchOS when the value is set to ``TransitType.air``.
    public var transitType: TransitType?

    public init(
        additionalInfoFields: [PassFieldContent]? = nil,
        auxiliaryFields: [PassFieldContent]? = nil,
        backFields: [PassFieldContent]? = nil,
        headerFields: [PassFieldContent]? = nil,
        primaryFields: [PassFieldContent]? = nil,
        secondaryFields: [PassFieldContent]? = nil,
        transitType: TransitType? = nil
    ) {
        self.additionalInfoFields = additionalInfoFields
        self.auxiliaryFields = auxiliaryFields
        self.backFields = backFields
        self.headerFields = headerFields
        self.primaryFields = primaryFields
        self.secondaryFields = secondaryFields
        self.transitType = transitType
    }
}

extension PassFields {
    public enum TransitType: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case air = "PKTransitTypeAir"
        case boat = "PKTransitTypeBoat"
        case bus = "PKTransitTypeBus"
        case generic = "PKTransitTypeGeneric"
        case train = "PKTransitTypeTrain"
    }
}
