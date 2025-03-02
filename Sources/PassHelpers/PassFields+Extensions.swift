// PassFields+Extensions.swift
// Copyright (c) 2025 hiimtmac inc.

import PassCore

extension PassFields {
    public static func boardingPass(
        transitType: TransitType,
        auxiliaryFields: [PassFieldContent]? = nil,
        backFields: [PassFieldContent]? = nil,
        headerFields: [PassFieldContent]? = nil,
        primaryFields: [PassFieldContent]? = nil,
        secondaryFields: [PassFieldContent]? = nil
    ) -> Self {
        Self(
            additionalInfoFields: nil,
            auxiliaryFields: auxiliaryFields,
            backFields: backFields,
            headerFields: headerFields,
            primaryFields: primaryFields,
            secondaryFields: secondaryFields,
            transitType: transitType
        )
    }

    public static func posterEventTicket(
        additionalInfoFields: [PassFieldContent]? = nil,
        auxiliaryFields: [PassFieldContent]? = nil,
        backFields: [PassFieldContent]? = nil,
        headerFields: [PassFieldContent]? = nil,
        primaryFields: [PassFieldContent]? = nil,
        secondaryFields: [PassFieldContent]? = nil
    ) -> Self {
        Self(
            additionalInfoFields: additionalInfoFields,
            auxiliaryFields: auxiliaryFields,
            backFields: backFields,
            headerFields: headerFields,
            primaryFields: primaryFields,
            secondaryFields: secondaryFields,
            transitType: nil
        )
    }

    public static func eventTicket(
        auxiliaryFields: [PassFieldContent]? = nil,
        backFields: [PassFieldContent]? = nil,
        headerFields: [PassFieldContent]? = nil,
        primaryFields: [PassFieldContent]? = nil,
        secondaryFields: [PassFieldContent]? = nil
    ) -> Self {
        Self(
            additionalInfoFields: nil,
            auxiliaryFields: auxiliaryFields,
            backFields: backFields,
            headerFields: headerFields,
            primaryFields: primaryFields,
            secondaryFields: secondaryFields,
            transitType: nil
        )
    }

    public static func coupon(
        auxiliaryFields: [PassFieldContent]? = nil,
        backFields: [PassFieldContent]? = nil,
        headerFields: [PassFieldContent]? = nil,
        primaryFields: [PassFieldContent]? = nil,
        secondaryFields: [PassFieldContent]? = nil
    ) -> Self {
        Self(
            additionalInfoFields: nil,
            auxiliaryFields: auxiliaryFields,
            backFields: backFields,
            headerFields: headerFields,
            primaryFields: primaryFields,
            secondaryFields: secondaryFields,
            transitType: nil
        )
    }

    public static func generic(
        auxiliaryFields: [PassFieldContent]? = nil,
        backFields: [PassFieldContent]? = nil,
        headerFields: [PassFieldContent]? = nil,
        primaryFields: [PassFieldContent]? = nil,
        secondaryFields: [PassFieldContent]? = nil
    ) -> Self {
        Self(
            additionalInfoFields: nil,
            auxiliaryFields: auxiliaryFields,
            backFields: backFields,
            headerFields: headerFields,
            primaryFields: primaryFields,
            secondaryFields: secondaryFields,
            transitType: nil
        )
    }

    public static func storeCard(
        auxiliaryFields: [PassFieldContent]? = nil,
        backFields: [PassFieldContent]? = nil,
        headerFields: [PassFieldContent]? = nil,
        primaryFields: [PassFieldContent]? = nil,
        secondaryFields: [PassFieldContent]? = nil
    ) -> Self {
        Self(
            additionalInfoFields: nil,
            auxiliaryFields: auxiliaryFields,
            backFields: backFields,
            headerFields: headerFields,
            primaryFields: primaryFields,
            secondaryFields: secondaryFields,
            transitType: nil
        )
    }
}
