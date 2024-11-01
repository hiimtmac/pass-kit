// PassFields.swift
// Copyright (c) 2024 hiimtmac inc.

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
    /// Additional fields to be displayed on the front of the pass.
    public var auxiliaryFields: [PassFieldContent]?

    /// Fields to be on the back of the pass.
    public var backFields: [PassFieldContent]?

    /// Fields to be displayed in the header on the front of the pass.
    ///
    /// Use header fields sparingly; unlike all other fields, they remain visible when a stack of passes are displayed.
    public var headerFields: [PassFieldContent]?

    /// Fields to be displayed prominently on the front of the pass.
    public var primaryFields: [PassFieldContent]?

    /// Fields to be displayed on the front of the pass.
    public var secondaryFields: [PassFieldContent]?

    /// Required for boarding passes; otherwise not allowed.
    public var transitType: TransitType?

    // iOS 18 Event Ticket with NFC Only
    public var additionalInfoFields: [PassFieldContent]?

    /// These keys are used for all pass styles and partition the fields into the various parts of the pass
    /// - Parameters:
    ///   - auxiliaryFields: Additional fields to be displayed on the front of the pass
    ///   - backFields: Fields to be on the back of the pass
    ///   - headerFields: Fields to be displayed in the header on the front of the pass
    ///   - primaryFields: Fields to be displayed prominently on the front of the pass
    ///   - secondaryFields: Fields to be displayed on the front of the pass
    ///   - transitType: Required for boarding passes; otherwise not allowed.
    public init(
        auxiliaryFields: [PassFieldContent]? = nil,
        backFields: [PassFieldContent]? = nil,
        headerFields: [PassFieldContent]? = nil,
        primaryFields: [PassFieldContent]? = nil,
        secondaryFields: [PassFieldContent]? = nil,
        transitType: TransitType? = nil,
        additionalInfoFields: [PassFieldContent]? = nil
    ) {
        self.auxiliaryFields = auxiliaryFields
        self.backFields = backFields
        self.headerFields = headerFields
        self.primaryFields = primaryFields
        self.secondaryFields = secondaryFields
        self.transitType = transitType
        self.additionalInfoFields = additionalInfoFields
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
