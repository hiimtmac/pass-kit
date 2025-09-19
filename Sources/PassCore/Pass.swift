// Pass.swift
// Copyright (c) 2025 hiimtmac inc.

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/TopLevel.html
/// The following sections list the required and optional keys used in this dictionary
public struct Pass: Codable, Equatable, Hashable, Sendable {
    // MARK: Required Keys

    /// (Required) A short description that iOS accessibility technologies use for a pass.
    ///
    /// Don’t try to include all of the data on the pass in its description, just include enough detail to distinguish passes of the same type.
    public var description: String

    /// Version of the file format. The value must be 1.
    public let formatVersion: Int

    /// Display name of the organization that originated and signed the pass.
    public var organizationName: String

    /// Pass type identifier, as issued by Apple. The value must correspond with your signing certificate.
    public var passTypeIdentifier: String

    /// Serial number that uniquely identifies the pass. No two passes with the same pass type identifier may have the same serial number.
    public var serialNumber: String

    /// Team identifier of the organization that originated and signed the pass, as issued by Apple.
    public var teamIdentifier: String

    // MARK: Optional Keys

    /// A URL that links to your accessiblity content, or the venue’s.
    ///
    /// This key works only for poster event tickets.
    public var accessibilityURL: URL?

    /// A URL that can link to experiences that someone can add to the pass.
    ///
    /// This key works only for poster event tickets.
    public var addOnURL: URL?

    /// A URL the system passes to the associated app from associatedStoreIdentifiers during launch.
    ///
    /// The app receives this URL in the `application(_:didFinishLaunchingWithOptions:)` and `application(_:open:options:)` methods of its app delegate.
    ///
    /// This key isn’t supported for watchOS.
    public var appLaunchURL: URL?

    /// An array of App Store identifiers for apps associated with the pass. The associated app on a device is the first item in the array that’s compatible with that device.
    ///
    /// A link to launch the app is on the back of the pass. If the app isn’t installed, the link opens the App Store.
    ///
    /// This key works only for payment passes.
    ///
    /// This key isn’t supported for watchOS.
    public var associatedStoreIdentifiers: [Int]?

    /// An array of additional App Store identifiers for apps associated with the pass. The associated app on a device is the first item in the array that’s compatible with that device.
    ///
    /// This key works only for poster event tickets. A link to launch the app is in the event guide of the pass. If the app isn’t installed, the link opens the App Store.
    ///
    /// This key isn’t supported for watchOS.
    public var auxiliaryStoreIdentifiers: [Int]?

    /// The authentication token to use with the web service in the ``webServiceURL`` key.
    public var authenticationToken: String?

    /// A background color for the pass, specified as a CSS-style RGB triple, such as rgb(23, 187, 82).
    public var backgroundColor: PassColor?

    /// A URL that links to the bag policy of the venue for the event that the pass represents.
    ///
    /// This key works only for poster event tickets.
    public var bagPolicyURL: URL?

    /// An object that represents a barcode on a pass.
    ///
    /// This object is deprecated. Use ``barcodes`` instead.
    public var barcode: Barcode?

    /// An array of objects that represent possible barcodes on a pass.
    ///
    /// The system uses the first displayable barcode for the device.
    public var barcodes: [Barcode]?

    /// An array of objects that represent the identity of Bluetooth Low Energy beacons the system uses to show a relevant pass.
    public var beacons: [Beacon]?

    /// An object that contains the information for a boarding pass.
    public var boardingPass: PassFields?

    /// The preferred email address to contact the venue, event, or issuer.
    ///
    /// This key works only for poster event tickets.
    public var contactVenueEmail: String?

    /// The phone number for contacting the venue, event, or issuer.
    ///
    /// This key works only for poster event tickets.
    public var contactVenuePhoneNumber: String?

    /// A URL that links to the website of the venue, event, or issuer.
    ///
    /// This key works only for poster event tickets.
    public var contactVenueWebsite: String?

    /// An object that contains the information for a coupon.
    public var coupon: PassFields?

    /// A URL that links to directions for the event.
    ///
    /// This key works only for poster event tickets.
    public var directionsInformationURL: URL?

    /// The text to display next to the logo on the pass.
    ///
    /// This key works only for poster event tickets
    public var eventLogoText: String?

    /// An object that contains the information for an event ticket.
    public var eventTicket: PassFields?

    /// The date and time the pass expires.
    ///
    /// The value needs to be a complete date that includes hours and minutes, and may optionally include seconds.
    public var expirationDate: Date?

    /// A background color for the footer of the pass, specified as a CSS-style RGB triple, such as rgb(100, 10, 110).
    ///
    /// This key works only for poster event tickets.
    public var footerBackgroundColor: PassColor?

    /// A foreground color for the pass, specified as a CSS-style RGB triple, such as rgb(100, 10, 110).
    public var foregroundColor: PassColor?

    /// An object that contains the information for a generic pass.
    public var generic: PassFields?

    /// An identifier the system uses to group related boarding passes or event tickets.
    ///
    /// Wallet displays passes with the same groupingIdentifier, passTypeIdentifier, and type as a group.
    ///
    /// Use this identifier to group passes that are tightly related, such as boarding passes for different connections on the same trip.
    public var groupingIdentifier: String?

    /// A color for the label text of the pass, specified as a CSS-style RGB triple, such as rgb(100, 10, 110).
    ///
    /// If you don’t provide a value, the system determines the label color.
    public var labelColor: PassColor?

    /// An array of up to 10 objects that represent geographic locations the system uses to show a relevant pass.
    public var locations: [Location]?

    /// The text to display next to the logo on the pass.
    ///
    /// This key doesn’t work for poster event tickets.
    public var logoText: String?

    /// The maximum distance, in meters, from a location in the locations array at which the pass is relevant.
    ///
    /// The system uses the smaller of this distance or the default distance.
    public var maxDistance: Double?

    /// A URL that links to a site for ordering merchandise for the event that the pass represents.
    ///
    /// This key works only for poster event tickets.
    public var merchandiseURL: URL?

    /// An object that contains the information to use for Value-Added Services protocol transactions.
    public var nfc: NFC?

    /// A URL that links to the food ordering page for the event that the pass represents.
    ///
    /// This key works only for poster event tickets.
    public var orderFoodURL: URL?

    /// A URL that links to parking information for the event that the pass represents.
    ///
    /// This key works only for poster event tickets.
    public var parkingInformationURL: URL?

    /// An array of schemes to validate the pass with.
    ///
    /// The system validates the pass and its contents to ensure they meet the schemes’ requirements, falling back to the designed type if validation fails for all the provided schemes.
    public var preferredStyleSchemes: [PreferredStyleScheme]?

    /// A URL that links to a site to purchase parking for the event that the pass represents.
    ///
    /// This key works only for poster event tickets.
    public var purchaseParkingURL: URL?

    /// The date and time when the pass becomes relevant, as a W3C timestamp, such as the start time of a movie.
    ///
    /// The value needs to be a complete date that includes hours and minutes, and may optionally include seconds.
    ///
    /// For information about the W3C timestamp format, see Time and Date Formats on the W3C website.
    ///
    /// This object is deprecated. Use relevantDates instead.
    public var relevantDate: Date?

    /// An array of objects that represent date intervals that the system uses to show a relevant pass.
    public var relevantDates: [RelevantDates]?

    /// A URL that links to the selling flow for the ticket the pass represents.
    ///
    /// This key works only for poster event tickets.
    public var sellURL: URL?

    /// An object that contains machine-readable metadata the system uses to offer a pass and suggest related actions.
    ///
    /// For example, setting Don’t Disturb mode for the duration of a movie.
    public var semantics: SemanticTags?

    /// A Boolean value introduced in iOS 11 that controls whether to show the Share button on the back of a pass.
    ///
    /// A value of `true` removes the button.
    /// The default value is `false`.
    ///
    /// This flag has no effect in earlier versions of iOS, nor does it prevent sharing the pass in some other way.
    public var sharingProhibited: Bool?

    /// An object that contains the information for a store card.
    public var storeCard: PassFields?

    /// A Boolean value that controls whether to display the strip image without a shine effect.
    ///
    /// The default value is `true`.
    public var suppressStripShine: Bool?

    /// A Boolean value that controls whether to display the header darkening gradient on poster event tickets.
    ///
    /// The default value is `false`.
    ///
    /// This key works only for poster event tickets.
    public var suppressHeaderDarkening: Bool?

    /// A URL that links to the transferring flow for the ticket that the pass represents.
    ///
    /// This key works only for poster event tickets.
    public var transferURL: URL?

    /// A URL that links to information about transit options in the area of the event that the pass represents.
    ///
    /// This key works only for poster event tickets.
    public var transitInformationURL: URL?

    /// A Boolean value that controls whether Wallet computes the foreground and label color that the pass uses. The system derives the background color from the background image of the pass.
    ///
    /// This key works only for poster event tickets.
    ///
    /// This key ignores the values that ``foregroundColor`` and ``labelColor`` specify.
    public var useAutomaticColors: Bool?

    /// A JSON dictionary that contains any custom information for companion apps.
    ///
    /// The data doesn’t appear to the user.
    ///
    /// For example, a pass for a cafe might include information about the customer’s favorite drink and sandwich in a machine-readable form.
    ///
    /// The companion app uses the data for placing an order for the usual.
    public var userInfo: [String: String]?

    /// A Boolean value that indicates that the pass is void, such as a redeemed, one-time-use coupon.
    ///
    /// The default value is `false`.
    public var voided: Bool?

    /// The URL for a web service that you use to update or personalize the pass.
    ///
    /// The URL can include an optional port number.
    public var webServiceURL: URL?
    
    /// A URL for changing the seat for the ticket.
    public var changeSeatURL: URL?
    
    /// A URL for in-flight entertainment.
    public var entertainmentURL: URL?
    
    /// A URL for adding checked bags for the ticket.
    public var purchaseAdditionalBaggageURL: URL?
    
    /// A URL that links to information to purchase lounge access.
    public var purchaseLoungeAccessURL: URL?
    
    /// A URL for purchasing in-flight wifi.
    public var purchaseWifiURL: URL?
    
    /// A URL for upgrading the flight.
    public var upgradeURL: URL?
    
    /// An ordered list of all upcoming pass information entries.
    public var upcomingPassInformation: [UpcomingPassInformationEntry]?
    
    /// A URL for management.
    public var managementURL: URL?
    
    /// A URL for registering a service animal.
    public var registerServiceAnimalURL: URL?
    
    /// A URL to report a lost bag.
    public var reportLostBagURL: URL?
    
    /// A URL to request a wheel chair.
    public var requestWheelchairURL: URL?
    
    /// The email for the transit provider.
    public var transitProviderEmail: String?
    
    /// The phone number for the transit provider.
    public var transitProviderPhoneNumber: String?
    
    /// The URL for the transit provider.
    public var transitProviderWebsiteURL: URL?
    

    public init(
        description: String,
        organizationName: String,
        passTypeIdentifier: String,
        serialNumber: String,
        teamIdentifier: String,
        accessibilityURL: URL? = nil,
        addOnURL: URL? = nil,
        appLaunchURL: URL? = nil,
        associatedStoreIdentifiers: [Int]? = nil,
        auxiliaryStoreIdentifiers: [Int]? = nil,
        authenticationToken: String? = nil,
        backgroundColor: PassColor? = nil,
        bagPolicyURL: URL? = nil,
        barcode: Barcode? = nil,
        barcodes: [Barcode]? = nil,
        beacons: [Beacon]? = nil,
        boardingPass: PassFields? = nil,
        contactVenueEmail: String? = nil,
        contactVenuePhoneNumber: String? = nil,
        contactVenueWebsite: String? = nil,
        coupon: PassFields? = nil,
        directionsInformationURL: URL? = nil,
        eventLogoText: String? = nil,
        eventTicket: PassFields? = nil,
        expirationDate: Date? = nil,
        footerBackgroundColor: PassColor? = nil,
        foregroundColor: PassColor? = nil,
        generic: PassFields? = nil,
        groupingIdentifier: String? = nil,
        labelColor: PassColor? = nil,
        locations: [Location]? = nil,
        logoText: String? = nil,
        maxDistance: Double? = nil,
        merchandiseURL: URL? = nil,
        nfc: NFC? = nil,
        orderFoodURL: URL? = nil,
        parkingInformationURL: URL? = nil,
        preferredStyleSchemes: [PreferredStyleScheme]? = nil,
        purchaseParkingURL: URL? = nil,
        relevantDate: Date? = nil,
        relevantDates: [RelevantDates]? = nil,
        sellURL: URL? = nil,
        semantics: SemanticTags? = nil,
        sharingProhibited: Bool? = nil,
        storeCard: PassFields? = nil,
        suppressStripShine: Bool? = nil,
        suppressHeaderDarkening: Bool? = nil,
        transferURL: URL? = nil,
        transitInformationURL: URL? = nil,
        useAutomaticColors: Bool? = nil,
        userInfo: [String: String]? = nil,
        voided: Bool? = nil,
        webServiceURL: URL? = nil,
        changeSeatURL: URL? = nil,
        entertainmentURL: URL? = nil,
        purchaseAdditionalBaggageURL: URL? = nil,
        purchaseLoungeAccessURL: URL? = nil,
        purchaseWifiURL: URL? = nil,
        upgradeURL: URL? = nil,
        upcomingPassInformation: [UpcomingPassInformationEntry]? = nil,
        managementURL: URL? = nil,
        registerServiceAnimalURL: URL? = nil,
        reportLostBagURL: URL? = nil,
        requestWheelchairURL: URL? = nil,
        transitProviderEmail: String? = nil,
        transitProviderPhoneNumber: String? = nil,
        transitProviderWebsiteURL: URL? = nil
    ) {
        self.description = description
        self.formatVersion = 1
        self.organizationName = organizationName
        self.passTypeIdentifier = passTypeIdentifier
        self.serialNumber = serialNumber
        self.teamIdentifier = teamIdentifier
        self.accessibilityURL = accessibilityURL
        self.addOnURL = addOnURL
        self.appLaunchURL = appLaunchURL
        self.associatedStoreIdentifiers = associatedStoreIdentifiers
        self.auxiliaryStoreIdentifiers = auxiliaryStoreIdentifiers
        self.authenticationToken = authenticationToken
        self.backgroundColor = backgroundColor
        self.bagPolicyURL = bagPolicyURL
        self.barcode = barcode
        self.barcodes = barcodes
        self.beacons = beacons
        self.boardingPass = boardingPass
        self.contactVenueEmail = contactVenueEmail
        self.contactVenuePhoneNumber = contactVenuePhoneNumber
        self.contactVenueWebsite = contactVenueWebsite
        self.coupon = coupon
        self.directionsInformationURL = directionsInformationURL
        self.eventLogoText = eventLogoText
        self.eventTicket = eventTicket
        self.expirationDate = expirationDate
        self.footerBackgroundColor = footerBackgroundColor
        self.foregroundColor = foregroundColor
        self.generic = generic
        self.groupingIdentifier = groupingIdentifier
        self.labelColor = labelColor
        self.locations = locations
        self.logoText = logoText
        self.maxDistance = maxDistance
        self.merchandiseURL = merchandiseURL
        self.nfc = nfc
        self.orderFoodURL = orderFoodURL
        self.parkingInformationURL = parkingInformationURL
        self.preferredStyleSchemes = preferredStyleSchemes
        self.purchaseParkingURL = purchaseParkingURL
        self.relevantDate = relevantDate
        self.relevantDates = relevantDates
        self.sellURL = sellURL
        self.semantics = semantics
        self.sharingProhibited = sharingProhibited
        self.storeCard = storeCard
        self.suppressStripShine = suppressStripShine
        self.suppressHeaderDarkening = suppressHeaderDarkening
        self.transferURL = transferURL
        self.transitInformationURL = transitInformationURL
        self.useAutomaticColors = useAutomaticColors
        self.userInfo = userInfo
        self.voided = voided
        self.webServiceURL = webServiceURL
        self.changeSeatURL = changeSeatURL
        self.entertainmentURL = entertainmentURL
        self.purchaseAdditionalBaggageURL = purchaseAdditionalBaggageURL
        self.purchaseLoungeAccessURL = purchaseLoungeAccessURL
        self.purchaseWifiURL = purchaseWifiURL
        self.upgradeURL = upgradeURL
        self.upcomingPassInformation = upcomingPassInformation
        self.managementURL = managementURL
        self.registerServiceAnimalURL = registerServiceAnimalURL
        self.reportLostBagURL = reportLostBagURL
        self.requestWheelchairURL = requestWheelchairURL
        self.transitProviderEmail = transitProviderEmail
        self.transitProviderPhoneNumber = transitProviderPhoneNumber
        self.transitProviderWebsiteURL = transitProviderWebsiteURL
    }
}
