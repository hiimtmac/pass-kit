// PassStructure.swift
// Copyright © 2022 hiimtmac

import Foundation

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/LowerLevel.html#//apple_ref/doc/uid/TP40012026-CH3-SW14
/// These keys are used for all pass styles and partition the fields into the various parts of the pass
public struct PassStructure: Codable {
    /// Additional fields to be displayed on the front of the pass.
    public var auxiliaryFields: [PassField]?
    /// Fields to be on the back of the pass.
    public var backFields: [PassField]?
    /// Fields to be displayed in the header on the front of the pass.
    /// Use header fields sparingly; unlike all other fields, they remain visible when a stack of passes are displayed.
    public var headerFields: [PassField]?
    /// Fields to be displayed prominently on the front of the pass.
    public var primaryFields: [PassField]?
    /// Fields to be displayed on the front of the pass.
    public var secondaryFields: [PassField]?
    /// Required for boarding passes; otherwise not allowed. Type of transit.
    /// Must be one of the following values: PKTransitTypeAir, PKTransitTypeBoat, PKTransitTypeBus, PKTransitTypeGeneric,PKTransitTypeTrain.
    public var transitType: PassTransitType?

    /// These keys are used for all pass styles and partition the fields into the various parts of the pass
    /// - Parameters:
    ///   - auxiliaryFields: Additional fields to be displayed on the front of the pass
    ///   - backFields: Fields to be on the back of the pass
    ///   - headerFields: Fields to be displayed in the header on the front of the pass
    ///   - primaryFields: Fields to be displayed prominently on the front of the pass
    ///   - secondaryFields: Fields to be displayed on the front of the pass
    ///   - transitType: Required for boarding passes; otherwise not allowed. Type of transit
    public init(
        auxiliaryFields: [PassField]? = nil,
        backFields: [PassField]? = nil,
        headerFields: [PassField]? = nil,
        primaryFields: [PassField]? = nil,
        secondaryFields: [PassField]? = nil,
        transitType: PassTransitType? = nil
    ) {
        self.auxiliaryFields = auxiliaryFields
        self.backFields = backFields
        self.headerFields = headerFields
        self.primaryFields = primaryFields
        self.secondaryFields = secondaryFields
        self.transitType = transitType
    }
}

extension PassStructure {
    public enum PassTransitType: String, Codable {
        case air = "PKTransitTypeAir"
        case boat = "PKTransitTypeBoat"
        case bus = "PKTransitTypeBus"
        case generic = "PKTransitTypeGeneric"
        case train = "PKTransitTypeTrain"
    }
}
