// PKPass.swift
// Copyright (c) 2023 hiimtmac inc.

import Foundation

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/TopLevel.html
/// The following sections list the required and optional keys used in this dictionary
public struct PKPass: Codable, Equatable, Hashable {
    /// - Standard Keys
    /// Information that is required for all passes.

    /// Brief description of the pass, used by the iOS accessibility technologies.
    /// Don’t try to include all of the data on the pass in its description, just include enough detail to distinguish passes of the same type.
    public var description: String

    /// Version of the file format. The value must be 1.
    public var formatVersion: Int
    /// Display name of the organization that originated and signed the pass.
    public var organizationName: String
    /// Pass type identifier, as issued by Apple. The value must correspond with your signing certificate.
    public var passTypeIdentifier: String
    /// Serial number that uniquely identifies the pass. No two passes with the same pass type identifier may have the same serial number.
    public var serialNumber: String
    /// Team identifier of the organization that originated and signed the pass, as issued by Apple.
    public var teamIdentifier: String

    /// - Associated App Keys
    /// Information about an app that is associated with a pass.

    /// A URL to be passed to the associated app when launching it.
    /// The app receives this URL in the application:didFinishLaunchingWithOptions: and application:openURL:options: methods of its app delegate.
    /// If this key is present, the associatedStoreIdentifiers key must also be present.
    public var appLaunchURL: URL?
    /// A list of iTunes Store item identifiers for the associated apps.
    /// Only one item in the list is used—the first item identifier for an app compatible with the current device. If the app is not installed, the link opens the App Store and shows the app. If the app is already installed, the link launches the app.
    public var associatedStoreIdentifiers: [Double]?

    /// - Companion App Keys
    /// Custom information about a pass provided for a companion app to use.

    /// Custom information for companion apps. This data is not displayed to the user.
    /// For example, a pass for a cafe could include information about the user’s favorite drink and sandwich in a machine-readable form for the companion app to read, making it easy to place an order for “the usual” from the app.
    public var userInfo: [String: String]?

    /// - Expiration Keys
    /// Information about when a pass expires and whether it is still valid.
    /// A pass is marked as expired if the current date is after the pass’s expiration date, or if the pass has been explicitly marked as voided.

    /// Date and time when the pass expires.
    /// The value must be a complete date with hours and minutes, and may optionally include seconds.
    public var expirationDate: Date?
    /// Indicates that the pass is void—for example, a one time use coupon that has been redeemed. The default value is false.
    public var voided: Bool?

    /// - Relevance Keys
    /// Information about where and when a pass is relevant.

    /// Beacons marking locations where the pass is relevant.
    public var beacons: [PKPassBeacon]?
    /// Locations where the pass is relevant. For example, the location of your store.
    public var locations: [PKPassLocation]?
    /// Maximum distance in meters from a relevant latitude and longitude that the pass is relevant. This number is compared to the pass’s default distance and the smaller value is used.
    public var maxDistance: Double?
    /// Recommended for event tickets and boarding passes; otherwise optional.
    /// Date and time when the pass becomes relevant. For example, the start time of a movie.
    /// The value must be a complete date with hours and minutes, and may optionally include seconds.
    public var relevantDate: Date?

    /// - Style Keys
    /// Keys that specify the pass style
    /// Provide exactly one key—the key that corresponds with the pass’s type.

    /// Information specific to a boarding pass.
    public var boardingPass: PKPassStructure?
    /// Information specific to a coupon.
    public var coupon: PKPassStructure?
    /// Information specific to an event ticket.
    public var eventTicket: PKPassStructure?
    /// Information specific to a generic pass.
    public var generic: PKPassStructure?
    /// Information specific to a store card.
    public var storeCard: PKPassStructure?

    /// - Visual Appearance Keys
    /// Keys that define the visual style and appearance of the pass.
    /// Information specific to the pass’s barcode. The system uses the first valid barcode dictionary in the array. Additional dictionaries can be added as fallbacks. For this dictionary’s keys, see Barcode Dictionary Keys.
    public var barcodes: [PKPassBarcode]?
    /// Background color of the pass, specified as an CSS-style RGB triple. For example, rgb(23, 187, 82).
    public var backgroundColor: PassColor?
    /// Foreground color of the pass, specified as a CSS-style RGB triple. For example, rgb(100, 10, 110).
    public var foregroundColor: PassColor?
    /// Optional for event tickets and boarding passes; otherwise not allowed. Identifier used to group related passes. If a grouping identifier is specified, passes with the same style, pass type identifier, and grouping identifier are displayed as a group. Otherwise, passes are grouped automatically.
    /// Use this to group passes that are tightly related, such as the boarding passes for different connections of the same trip.
    public var groupingIdentifier: String?
    /// Color of the label text, specified as a CSS-style RGB triple. For example, rgb(255, 255, 255).
    /// If omitted, the label color is determined automatically.
    public var labelColor: PassColor?
    /// Text displayed next to the logo on the pass.
    public var logoText: String?

    /// - Web Service Keys
    /// Information used to update passes using the web service.
    /// If a web service URL is provided, an authentication token is required; otherwise, these keys are not allowed.

    /// The authentication token to use with the web service. The token must be 16 characters or longer.
    public var authenticationToken: String?
    /// The URL of a web service that conforms to the API described in PassKit Web Service Reference (https://developer.apple.com/library/archive/documentation/PassKit/Reference/PassKit_WebService/WebService.html#//apple_ref/doc/uid/TP40011988).
    /// The web service must use the HTTPS protocol; the leading https:// is included in the value of this key.
    /// On devices configured for development, there is UI in Settings to allow HTTP web services.
    public var webServiceURL: URL?

    /// - NFC-Enabled Pass Keys
    /// NFC-enabled pass keys support sending reward card information as part of an Apple Pay transaction.
    /// Important: NFC-enabled pass keys are only supported in passes that contain an Enhanced Passbook/NFC certificate. For more information, contact merchant support at https://developer.apple.com/contact/passkit/.
    /// Passes can send reward card information to a terminal as part of an Apple Pay transaction. This feature requires a payment terminal that supports NFC-entitled passes. Specifically, the terminal must implement the Value Added Services Protocol.
    /// Passes provide the required information using the nfc key. The value of this key is a dictionary containing the keys described in NFC Dictionary Keys. This functionality allows passes to act as the user’s credentials in the context of the NFC Value Added Service Protocol. It is available only for storeCard style passes.

    /// Information used for Value Added Service Protocol transactions.
    public var nfc: PKPassNFC?

    /// Creates a Pass object
    /// - Parameters:
    ///   - description: Brief description of the pass, used by the iOS accessibility technologies
    ///   - organizationName: Display name of the organization that originated and signed the pass
    ///   - passTypeIdentifier: Pass type identifier, as issued by Apple
    ///   - serialNumber: Serial number that uniquely identifies the pass
    ///   - teamIdentifier: Team identifier of the organization that originated and signed the pass, as issued by Apple
    ///   - appLaunchURL: A URL to be passed to the associated app when launching it
    ///   - associatedStoreIdentifiers: A list of iTunes Store item identifiers for the associated apps
    ///   - userInfo: Custom information for companion apps
    ///   - expirationDate: Date and time when the pass expires
    ///   - voided: Indicates that the pass is void
    ///   - beacons: Beacons marking locations where the pass is relevant
    ///   - locations: Locations where the pass is relevant
    ///   - maxDistance: Maximum distance in meters from a relevant latitude and longitude that the pass is relevant
    ///   - relevantDate: Date and time when the pass becomes relevant
    ///   - boardingPass: Information specific to a boarding pass
    ///   - coupon: Information specific to a coupon
    ///   - eventTicket: Information specific to an event ticket
    ///   - generic: Information specific to a generic pass
    ///   - storeCard: Information specific to a store card
    ///   - barcodes: Information specific to the pass’s barcode
    ///   - backgroundColor: Background color of the pass, specified as an CSS-style RGB triple
    ///   - foregroundColor: Foreground color of the pass, specified as a CSS-style RGB triple
    ///   - groupingIdentifier: Identifier used to group related passes
    ///   - labelColor: Color of the label text, specified as a CSS-style RGB triple
    ///   - logoText: Text displayed next to the logo on the pass
    ///   - suppressStripShine: If true, the strip image is displayed without a shine effect
    ///   - authenticationToken: The authentication token to use with the web service
    ///   - webServiceURL: The URL of a web service that conforms to the API described in PassKit Web Service Reference
    ///   - nfc: NFC-enabled pass keys support sending reward card information as part of an Apple Pay transaction
    public init(
        description: String,
        organizationName: String,
        passTypeIdentifier: String,
        serialNumber: String,
        teamIdentifier: String,
        appLaunchURL: URL? = nil,
        associatedStoreIdentifiers: [Double]? = nil,
        userInfo: [String: String]? = nil,
        expirationDate: Date? = nil,
        voided: Bool? = nil,
        beacons: [PKPassBeacon]? = nil,
        locations: [PKPassLocation]? = nil,
        maxDistance: Double? = nil,
        relevantDate: Date? = nil,
        boardingPass: PKPassStructure? = nil,
        coupon: PKPassStructure? = nil,
        eventTicket: PKPassStructure? = nil,
        generic: PKPassStructure? = nil,
        storeCard: PKPassStructure? = nil,
        barcodes: [PKPassBarcode]? = nil,
        backgroundColor: PassColor? = nil,
        foregroundColor: PassColor? = nil,
        groupingIdentifier: String? = nil,
        labelColor: PassColor? = nil,
        logoText: String? = nil,
        authenticationToken: String? = nil,
        webServiceURL: URL? = nil,
        nfc: PKPassNFC? = nil
    ) {
        self.description = description
        self.formatVersion = 1
        self.organizationName = organizationName
        self.passTypeIdentifier = passTypeIdentifier
        self.serialNumber = serialNumber
        self.teamIdentifier = teamIdentifier
        self.appLaunchURL = appLaunchURL
        self.associatedStoreIdentifiers = associatedStoreIdentifiers
        self.userInfo = userInfo
        self.expirationDate = expirationDate
        self.voided = voided
        self.beacons = beacons
        self.locations = locations
        self.maxDistance = maxDistance
        self.relevantDate = relevantDate
        self.boardingPass = boardingPass
        self.coupon = coupon
        self.eventTicket = eventTicket
        self.generic = generic
        self.storeCard = storeCard
        self.barcodes = barcodes
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.groupingIdentifier = groupingIdentifier
        self.labelColor = labelColor
        self.logoText = logoText
        self.authenticationToken = authenticationToken
        self.webServiceURL = webServiceURL
        self.nfc = nfc
    }
}

// MARK: - Conveniences

extension PKPass {
    public static func boardingPass(
        description: String,
        organizationName: String,
        passTypeIdentifier: String,
        serialNumber: String,
        teamIdentifier: String,
        appLaunchURL: URL? = nil,
        associatedStoreIdentifiers: [Double]? = nil,
        userInfo: [String: String]? = nil,
        expirationDate: Date? = nil,
        voided: Bool? = nil,
        beacons: [PKPassBeacon]? = nil,
        locations: [PKPassLocation]? = nil,
        maxDistance: Double? = nil,
        relevantDate: Date? = nil,
        structure: PKPassStructure,
        barcodes: [PKPassBarcode]? = nil,
        backgroundColor: PassColor? = nil,
        foregroundColor: PassColor? = nil,
        groupingIdentifier: String? = nil,
        labelColor: PassColor? = nil,
        logoText: String? = nil,
        authenticationToken: String? = nil,
        webServiceURL: URL? = nil,
        nfc: PKPassNFC? = nil
    ) -> Self {
        self.init(
            description: description,
            organizationName: organizationName,
            passTypeIdentifier: passTypeIdentifier,
            serialNumber: serialNumber,
            teamIdentifier: teamIdentifier,
            appLaunchURL: appLaunchURL,
            associatedStoreIdentifiers: associatedStoreIdentifiers,
            userInfo: userInfo,
            expirationDate: expirationDate,
            voided: voided,
            beacons: beacons,
            locations: locations,
            maxDistance: maxDistance,
            relevantDate: relevantDate,
            boardingPass: structure,
            barcodes: barcodes,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            groupingIdentifier: groupingIdentifier,
            labelColor: labelColor,
            logoText: logoText,
            authenticationToken: authenticationToken,
            webServiceURL: webServiceURL,
            nfc: nfc
        )
    }

    public static func coupon(
        description: String,
        organizationName: String,
        passTypeIdentifier: String,
        serialNumber: String,
        teamIdentifier: String,
        appLaunchURL: URL? = nil,
        associatedStoreIdentifiers: [Double]? = nil,
        userInfo: [String: String]? = nil,
        expirationDate: Date? = nil,
        voided: Bool? = nil,
        beacons: [PKPassBeacon]? = nil,
        locations: [PKPassLocation]? = nil,
        maxDistance: Double? = nil,
        relevantDate: Date? = nil,
        structure: PKPassStructure,
        barcodes: [PKPassBarcode]? = nil,
        backgroundColor: PassColor? = nil,
        foregroundColor: PassColor? = nil,
        labelColor: PassColor? = nil,
        logoText: String? = nil,
        authenticationToken: String? = nil,
        webServiceURL: URL? = nil,
        nfc: PKPassNFC? = nil
    ) -> Self {
        self.init(
            description: description,
            organizationName: organizationName,
            passTypeIdentifier: passTypeIdentifier,
            serialNumber: serialNumber,
            teamIdentifier: teamIdentifier,
            appLaunchURL: appLaunchURL,
            associatedStoreIdentifiers: associatedStoreIdentifiers,
            userInfo: userInfo,
            expirationDate: expirationDate,
            voided: voided,
            beacons: beacons,
            locations: locations,
            maxDistance: maxDistance,
            relevantDate: relevantDate,
            coupon: structure,
            barcodes: barcodes,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            labelColor: labelColor,
            logoText: logoText,
            authenticationToken: authenticationToken,
            webServiceURL: webServiceURL,
            nfc: nfc
        )
    }

    public static func eventTicket(
        description: String,
        organizationName: String,
        passTypeIdentifier: String,
        serialNumber: String,
        teamIdentifier: String,
        appLaunchURL: URL? = nil,
        associatedStoreIdentifiers: [Double]? = nil,
        userInfo: [String: String]? = nil,
        expirationDate: Date? = nil,
        voided: Bool? = nil,
        beacons: [PKPassBeacon]? = nil,
        locations: [PKPassLocation]? = nil,
        maxDistance: Double? = nil,
        relevantDate: Date? = nil,
        structure: PKPassStructure,
        barcodes: [PKPassBarcode]? = nil,
        backgroundColor: PassColor? = nil,
        foregroundColor: PassColor? = nil,
        groupingIdentifier: String? = nil,
        labelColor: PassColor? = nil,
        logoText: String? = nil,
        authenticationToken: String? = nil,
        webServiceURL: URL? = nil,
        nfc: PKPassNFC? = nil
    ) -> Self {
        self.init(
            description: description,
            organizationName: organizationName,
            passTypeIdentifier: passTypeIdentifier,
            serialNumber: serialNumber,
            teamIdentifier: teamIdentifier,
            appLaunchURL: appLaunchURL,
            associatedStoreIdentifiers: associatedStoreIdentifiers,
            userInfo: userInfo,
            expirationDate: expirationDate,
            voided: voided,
            beacons: beacons,
            locations: locations,
            maxDistance: maxDistance,
            relevantDate: relevantDate,
            eventTicket: structure,
            barcodes: barcodes,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            groupingIdentifier: groupingIdentifier,
            labelColor: labelColor,
            logoText: logoText,
            authenticationToken: authenticationToken,
            webServiceURL: webServiceURL,
            nfc: nfc
        )
    }

    public static func generic(
        description: String,
        organizationName: String,
        passTypeIdentifier: String,
        serialNumber: String,
        teamIdentifier: String,
        appLaunchURL: URL? = nil,
        associatedStoreIdentifiers: [Double]? = nil,
        userInfo: [String: String]? = nil,
        expirationDate: Date? = nil,
        voided: Bool? = nil,
        beacons: [PKPassBeacon]? = nil,
        locations: [PKPassLocation]? = nil,
        maxDistance: Double? = nil,
        relevantDate: Date? = nil,
        structure: PKPassStructure,
        barcodes: [PKPassBarcode]? = nil,
        backgroundColor: PassColor? = nil,
        foregroundColor: PassColor? = nil,
        labelColor: PassColor? = nil,
        logoText: String? = nil,
        authenticationToken: String? = nil,
        webServiceURL: URL? = nil,
        nfc: PKPassNFC? = nil
    ) -> Self {
        self.init(
            description: description,
            organizationName: organizationName,
            passTypeIdentifier: passTypeIdentifier,
            serialNumber: serialNumber,
            teamIdentifier: teamIdentifier,
            appLaunchURL: appLaunchURL,
            associatedStoreIdentifiers: associatedStoreIdentifiers,
            userInfo: userInfo,
            expirationDate: expirationDate,
            voided: voided,
            beacons: beacons,
            locations: locations,
            maxDistance: maxDistance,
            relevantDate: relevantDate,
            generic: structure,
            barcodes: barcodes,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            labelColor: labelColor,
            logoText: logoText,
            authenticationToken: authenticationToken,
            webServiceURL: webServiceURL,
            nfc: nfc
        )
    }

    public static func storeCard(
        description: String,
        organizationName: String,
        passTypeIdentifier: String,
        serialNumber: String,
        teamIdentifier: String,
        appLaunchURL: URL? = nil,
        associatedStoreIdentifiers: [Double]? = nil,
        userInfo: [String: String]? = nil,
        expirationDate: Date? = nil,
        voided: Bool? = nil,
        beacons: [PKPassBeacon]? = nil,
        locations: [PKPassLocation]? = nil,
        maxDistance: Double? = nil,
        relevantDate: Date? = nil,
        structure: PKPassStructure,
        barcodes: [PKPassBarcode]? = nil,
        backgroundColor: PassColor? = nil,
        foregroundColor: PassColor? = nil,
        labelColor: PassColor? = nil,
        logoText: String? = nil,
        authenticationToken: String? = nil,
        webServiceURL: URL? = nil,
        nfc: PKPassNFC? = nil
    ) -> Self {
        self.init(
            description: description,
            organizationName: organizationName,
            passTypeIdentifier: passTypeIdentifier,
            serialNumber: serialNumber,
            teamIdentifier: teamIdentifier,
            appLaunchURL: appLaunchURL,
            associatedStoreIdentifiers: associatedStoreIdentifiers,
            userInfo: userInfo,
            expirationDate: expirationDate,
            voided: voided,
            beacons: beacons,
            locations: locations,
            maxDistance: maxDistance,
            relevantDate: relevantDate,
            storeCard: structure,
            barcodes: barcodes,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            labelColor: labelColor,
            logoText: logoText,
            authenticationToken: authenticationToken,
            webServiceURL: webServiceURL,
            nfc: nfc
        )
    }
}
