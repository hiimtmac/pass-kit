// PKPassStructure.swift
// Copyright (c) 2023 hiimtmac inc.

import Foundation

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/LowerLevel.html#//apple_ref/doc/uid/TP40012026-CH3-SW14
/// These keys are used for all pass styles and partition the fields into the various parts of the pass
public struct PKPassStructure: Codable, Equatable, Hashable {
    /// Additional fields to be displayed on the front of the pass.
    public var auxiliaryFields: [PKPassField]?
    /// Fields to be on the back of the pass.
    public var backFields: [PKPassField]?
    /// Fields to be displayed in the header on the front of the pass.
    /// Use header fields sparingly; unlike all other fields, they remain visible when a stack of passes are displayed.
    public var headerFields: [PKPassField]?
    /// Fields to be displayed prominently on the front of the pass.
    public var primaryFields: [PKPassField]?
    /// Fields to be displayed on the front of the pass.
    public var secondaryFields: [PKPassField]?
    /// Required for boarding passes; otherwise not allowed. Type of transit.
    /// Must be one of the following values: PKTransitTypeAir, PKTransitTypeBoat, PKTransitTypeBus, PKTransitTypeGeneric,PKTransitTypeTrain.
    public var transitType: PKPassTransitType?

    /// These keys are used for all pass styles and partition the fields into the various parts of the pass
    /// - Parameters:
    ///   - auxiliaryFields: Additional fields to be displayed on the front of the pass
    ///   - backFields: Fields to be on the back of the pass
    ///   - headerFields: Fields to be displayed in the header on the front of the pass
    ///   - primaryFields: Fields to be displayed prominently on the front of the pass
    ///   - secondaryFields: Fields to be displayed on the front of the pass
    ///   - transitType: Required for boarding passes; otherwise not allowed. Type of transit
    public init(
        auxiliaryFields: [PKPassField]? = nil,
        backFields: [PKPassField]? = nil,
        headerFields: [PKPassField]? = nil,
        primaryFields: [PKPassField]? = nil,
        secondaryFields: [PKPassField]? = nil,
        transitType: PKPassTransitType? = nil
    ) {
        self.auxiliaryFields = auxiliaryFields
        self.backFields = backFields
        self.headerFields = headerFields
        self.primaryFields = primaryFields
        self.secondaryFields = secondaryFields
        self.transitType = transitType
    }
}

extension PKPassStructure {
    public enum PKPassTransitType: String, Codable, Equatable, Hashable, CaseIterable {
        case air = "PKTransitTypeAir"
        case boat = "PKTransitTypeBoat"
        case bus = "PKTransitTypeBus"
        case generic = "PKTransitTypeGeneric"
        case train = "PKTransitTypeTrain"
    }
}

// MARK: - Conveniences

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
/// Use the userInfo key to store information that should not appear on the pass.
extension PKPassStructure {
    public static func generic(
        header1: PKPassField? = nil,
        header2: PKPassField? = nil,
        header3: PKPassField? = nil,
        primary: PKPassField? = nil,
        secondary1: PKPassField? = nil,
        secondary2: PKPassField? = nil,
        secondary3: PKPassField? = nil,
        secondary4: PKPassField? = nil,
        auxiliary1: PKPassField? = nil,
        auxiliary2: PKPassField? = nil,
        auxiliary3: PKPassField? = nil,
        auxiliary4: PKPassField? = nil,
        backFields: [PKPassField]? = nil
    ) -> Self {
        self.init(
            auxiliaryFields: [auxiliary1, auxiliary2, auxiliary3, auxiliary4].nilIfEmpty(),
            backFields: backFields,
            headerFields: [header1, header2, header3].nilIfEmpty(),
            primaryFields: [primary].nilIfEmpty(),
            secondaryFields: [secondary1, secondary2, secondary3, secondary4].nilIfEmpty()
        )
    }

    public static func transit(
        header1: PKPassField? = nil,
        header2: PKPassField? = nil,
        header3: PKPassField? = nil,
        primary1: PKPassField? = nil,
        primary2: PKPassField? = nil,
        secondary1: PKPassField? = nil,
        secondary2: PKPassField? = nil,
        secondary3: PKPassField? = nil,
        secondary4: PKPassField? = nil,
        auxiliary1: PKPassField? = nil,
        auxiliary2: PKPassField? = nil,
        auxiliary3: PKPassField? = nil,
        auxiliary4: PKPassField? = nil,
        auxiliary5: PKPassField? = nil,
        backFields: [PKPassField]? = nil,
        transitType: PKPassTransitType
    ) -> Self {
        self.init(
            auxiliaryFields: [auxiliary1, auxiliary2, auxiliary3, auxiliary4, auxiliary5].nilIfEmpty(),
            backFields: backFields,
            headerFields: [header1, header2, header3].nilIfEmpty(),
            primaryFields: [primary1, primary2].nilIfEmpty(),
            secondaryFields: [secondary1, secondary2, secondary3, secondary4].nilIfEmpty(),
            transitType: transitType
        )
    }
}

extension Array where Element == PKPassField? {
    fileprivate func nilIfEmpty() -> [PKPassField]? {
        let filter = self.compactMap { $0 }
        return filter.isEmpty ? nil : filter
    }
}
