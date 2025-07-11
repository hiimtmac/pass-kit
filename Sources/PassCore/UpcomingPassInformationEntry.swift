// SemanticTags.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation

// https://developer.apple.com/documentation/walletpasses/upcomingpassinformationentry

public struct UpcomingPassInformationEntry: Codable, Equatable, Hashable, Sendable {
    /// A collection of URLs used to populate UI elements in the details view.
    public var URLs: URLs?
    
    /// The fields of information displayed on the Additional Info section below a pass.
    public var additionalInfoFields: PassFieldContent?
    
    /// An array of App Store identifiers for apps associated with the upcoming pass information entry. The associated app on a device is the first item in the array that’s compatible with that device. This key works only for upcoming pass information entries for an event. A link to launch the app is in the event guide of the entry details view. If the app isn’t installed, the link opens to the App Store.
    public var auxiliaryStoreIdentifiers: [Int]?
    
    /// The fields of information displayed on the details view of the upcoming pass information entry.
    public var backFields: PassFieldContent?
    
    /// Information about the start and end time of the upcoming pass information entry. If omitted, the entry is labeled as TBD.
    public var dateInformation: DateInformation?
    
    /// A string that uniquely identifies the upcoming pass information entry. The identifier needs to be unique for each upcoming information entry.
    public var identifier: String
    
    /// A collection of image names used to populate images in the details view.
    public var images: UpcomingPassInformationEntry.Images?
    
    /// Indicates whether the upcoming pass information entry is currently active. The default value is false.
    public var isActive: Bool?
    
    /// The name of the upcoming pass information entry.
    public var name: String
    
    /// The semantic, machine-readable metadata about the upcoming pass information entry.
    public var semantics: SemanticTags?
    
    /// The type of upcoming pass information entry.
    public let type: String
    
    public init(
        URLs: URLs? = nil,
        additionalInfoFields: PassFieldContent? = nil,
        auxiliaryStoreIdentifiers: [Int]? = nil,
        backFields: PassFieldContent? = nil,
        dateInformation: DateInformation? = nil,
        identifier: String,
        images: UpcomingPassInformationEntry.Images? = nil,
        isActive: Bool? = nil,
        name: String,
        semantics: SemanticTags? = nil
    ) {
        self.URLs = URLs
        self.additionalInfoFields = additionalInfoFields
        self.auxiliaryStoreIdentifiers = auxiliaryStoreIdentifiers
        self.backFields = backFields
        self.dateInformation = dateInformation
        self.identifier = identifier
        self.images = images
        self.isActive = isActive
        self.name = name
        self.semantics = semantics
        self.type = "event"
    }
}

extension UpcomingPassInformationEntry {
    public struct URLs: Codable, Equatable, Hashable, Sendable {
        /// A URL that links to your or the venue’s accessiblity content.
        public var accessibilityURL: URL?
        
        /// A URL that links to experiences that you can add on to your ticket or that allows you to access your existing prepurchased or preloaded add-on experiences, including any necessary QR or barcode links to access the experience.
        ///
        /// For example, loaded value or upgrades for an experience.
        public var addOnURL: URL?
        
        /// A URL that links out to the bag policy of the venue.
        public var bagPolicyURL: URL?
        
        /// The preferred email address to contact the venue, event, or issuer.
        public var contactVenueEmail: String?
        
        /// The preferred phone number to contact the venue, event, or issuer.
        public var contactVenuePhoneNumber: String?
        
        /// A URL that links the user to the website of the venue, event, or issuer.
        public var contactVenueWebsite: URL?
        
        /// A URL that links to content you have about getting to the venue.
        public var directionsInformationURL: URL?
        
        /// A URL that links to order merchandise for the specific event.
        ///
        /// This can be a ship-to-home ecommerce site, a pre-order to pickup at the venue, or other appropriate merchandise flow.
        /// This link can also be updated throughout the user’s journey to provide more accurately tailored links at certain times.
        /// For example, before versus after a user enters an event.
        /// This can be done through a pass update.
        /// For more information on updating a pass, see Distributing and updating a pass.
        public var merchandiseURL: URL?
         
        /// A URL that links out to the food-ordering page for the venue.
        ///
        /// This can be in-seat food delivery, pre-order for pickup at a vendor, or other appropriate food-ordering service.
        public var orderFoodURL: URL?
        
        /// A URL that links to any information you have about parking.
        public var parkingInformationURL: URL?
        
        /// A URL that links to your experience to buy or access prepaid parking or general parking information.
        public var purchaseParkingURL: URL?
        
        /// A URL that launches the user into the issuer’s flow for selling their current ticket.
        ///
        /// Provide as deep a link as possible into the sale flow.
        public var sellURL: URL?
        
        /// A URL that launches the user into the issuer’s flow for transferring the current ticket.
        ///
        /// Provide as deep a link as possible into the transfer flow.
        public var transferURL: URL?
        
        /// A URL that links to documentation you have about public or private transit to the venue.
        public var transitInformationURL: URL?
        
        public init(
            accessibilityURL: URL? = nil,
            addOnURL: URL? = nil,
            bagPolicyURL: URL? = nil,
            contactVenueEmail: String? = nil,
            contactVenuePhoneNumber: String? = nil,
            contactVenueWebsite: URL? = nil,
            directionsInformationURL: URL? = nil,
            merchandiseURL: URL? = nil,
            orderFoodURL: URL? = nil,
            parkingInformationURL: URL? = nil,
            purchaseParkingURL: URL? = nil,
            sellURL: URL? = nil,
            transferURL: URL? = nil,
            transitInformationURL: URL? = nil
        ) {
            self.accessibilityURL = accessibilityURL
            self.addOnURL = addOnURL
            self.bagPolicyURL = bagPolicyURL
            self.contactVenueEmail = contactVenueEmail
            self.contactVenuePhoneNumber = contactVenuePhoneNumber
            self.contactVenueWebsite = contactVenueWebsite
            self.directionsInformationURL = directionsInformationURL
            self.merchandiseURL = merchandiseURL
            self.orderFoodURL = orderFoodURL
            self.parkingInformationURL = parkingInformationURL
            self.purchaseParkingURL = purchaseParkingURL
            self.sellURL = sellURL
            self.transferURL = transferURL
            self.transitInformationURL = transitInformationURL
        }
    }
    
    public struct DateInformation: Codable, Equatable, Hashable, Sendable {
        /// The start date of the upcoming pass information entry.
        ///
        /// If omitted, the entry lists the Time and Date as TBD.
        public var date: Date?
        
        /// Indicates whether the entry should ignore the time components of the date.
        public var ignoreTimeComponents: Bool?
        
        /// Indicates whether the entry spans the entire day and that the time components should be ignored.
        public var isAllDay: Bool?
        
        /// Indicates whether the provided time of the event hasn’t been announced (commonly referred to as TBA).
        public var isUnannounced: Bool?
        
        /// Indicates whether the provided time of the event hasn’t been determined (commonly referred to as TBD).
        public var isUndetermined: Bool?
        
        /// The time zone to adjust the date into. If omitted, the entry uses the current time zone of the device.
        public var timeZone: String?
        
        public init(
            date: Date? = nil,
            ignoreTimeComponents: Bool? = nil,
            isAllDay: Bool? = nil,
            isUnannounced: Bool? = nil,
            isUndetermined: Bool? = nil,
            timeZone: String? = nil
        ) {
            self.date = date
            self.ignoreTimeComponents = ignoreTimeComponents
            self.isAllDay = isAllDay
            self.isUnannounced = isUnannounced
            self.isUndetermined = isUndetermined
            self.timeZone = timeZone
        }
    }
    
    public struct Images: Codable, Equatable, Hashable, Sendable {
        /// The name of the image file used for the header image on the details screen.
        ///
        /// This can be a remote asset.
        public var headerImage: UpcomingPassInformationEntryType.Image?
        
        /// The name of the image file used for the venue map in the event guide for each upcoming pass information entry.
        ///
        /// This can be a remote asset and is available for event entries.
        public var venueMap: UpcomingPassInformationEntryType.Image?
    }
}

public enum UpcomingPassInformationEntryType {
    public struct Image: Codable, Equatable, Hashable, Sendable {
        /// A list of URLs used to retreive an image.
        ///
        /// The upcoming pass information entry uses the item that best matches the device’s scale.
        public var URLs: [ImageURLEntry]?
        
        /// Indicates whether to use the local equivalent image instead of the image specified by URLs.
        public var reuseExisting: Bool?
        
        public init(
            URLs: [ImageURLEntry]? = nil,
            reuseExisting: Bool? = nil
        ) {
            self.URLs = URLs
            self.reuseExisting = reuseExisting
        }
    }
    
    public struct ImageURLEntry: Codable, Equatable, Hashable, Sendable {
        /// The SHA256 hash of the image.
        public var SHA256: String
        
        /// The URL that points to the image asset to be downloaded.
        ///
        /// This must be an https link.
        public var URL: URL
        
        /// The scale of the image.
        ///
        /// If unspecified, defaults to 1.
        public var scale: Double?
        
        /// Size of the image asset in bytes. The maximum allowed size is 2 megabytes.
        public var size: Int?
        
        public init(
            SHA256: String,
            URL: URL,
            scale: Double? = nil,
            size: Int? = nil
        ) {
            self.SHA256 = SHA256
            self.URL = URL
            self.scale = scale
            self.size = size
        }
    }
}
