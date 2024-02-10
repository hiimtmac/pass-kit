// SemanticTags.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation

// https://developer.apple.com/documentation/walletpasses/semantictags

public struct SemanticTags: Codable, Equatable, Hashable {
    /// The IATA airline code, such as “EX” for flightCode “EX123”. Use this key only for airline boarding passes.
    public var airlineCode: String?

    /// An array of the Apple Music persistent ID for each artist performing at the event, in decreasing order of significance.
    ///
    /// Use this key for any type of event ticket.
    public var artistIDs: [String]?

    /// The unique abbreviation of the away team’s name. Use this key only for a sports event ticket.
    public var awayTeamAbbreviation: String?

    /// The home location of the away team. Use this key only for a sports event ticket.
    public var awayTeamLocation: String?

    /// The name of the away team. Use this key only for a sports event ticket.
    public var awayTeamName: String?

    /// The current balance redeemable with the pass. Use this key only for a store card pass.
    public var balance: SemanticTagType.CurrencyAmount?

    /// A group number for boarding. Use this key for any type of boarding pass.
    public var boardingGroup: String?

    /// A sequence number for boarding. Use this key for any type of boarding pass.
    public var boardingSequenceNumber: String?

    /// The number of the passenger car. A train car is also called a carriage, wagon, coach, or bogie in some countries. Use this key only for a train or other rail boarding pass.
    public var carNumber: String?

    /// A booking or reservation confirmation number. Use this key for any type of boarding pass.
    public var confirmationNumber: String?

    /// The updated date and time of arrival, if different from the originally scheduled date and time. Use this key for any type of boarding pass.
    public var currentArrivalDate: Date?

    /// The updated date and time of boarding, if different from the originally scheduled date and time. Use this key for any type of boarding pass.
    public var currentBoardingDate: Date?

    /// The updated departure date and time, if different from the originally scheduled date and time. Use this key for any type of boarding pass.
    public var currentDepartureDate: Date?

    /// The IATA airport code for the departure airport, such as “MPM” or “LHR”. Use this key only for airline boarding passes.
    public var departureAirportCode: String?

    /// The full name of the departure airport, such as “Maputo International Airport”. Use this key only for airline boarding passes.
    public var departureAirportName: String?

    /// The gate number or letters of the departure gate, such as “1A”. Do not include the word “Gate.”
    public var departureGate: String?

    /// An object that represents the geographic coordinates of the transit departure location, suitable for display on a map. If possible, use precise locations, which are more useful to travelers; for example, the specific location of an airport gate. Use this key for any type of boarding pass.
    public var departureLocation: SemanticTagType.Location?

    /// A brief description of the departure location. For example, for a flight departing from an airport whose code is “LHR,” an appropriate description might be “London, Heathrow“. Use this key for any type of boarding pass.
    public var departureLocationDescription: String?

    /// The name of the departure platform, such as “A”. Don’t include the word “Platform.” Use this key only for a train or other rail boarding pass.
    public var departurePlatform: String?

    /// The name of the departure station, such as “1st Street Station”. Use this key only for a train or other rail boarding pass.
    public var departureStationName: String?

    /// The name or letter of the departure terminal, such as “A”. Don’t include the word “Terminal.” Use this key only for airline boarding passes.
    public var departureTerminal: String?

    /// The IATA airport code for the destination airport, such as “MPM” or “LHR”. Use this key only for airline boarding passes.
    public var destinationAirportCode: String?

    /// The full name of the destination airport, such as “London Heathrow”. Use this key only for airline boarding passes.
    public var destinationAirportName: String?

    /// The gate number or letter of the destination gate, such as “1A”. Don’t include the word “Gate.” Use this key only for airline boarding passes.
    public var destinationGate: String?

    /// An object that represents the geographic coordinates of the transit departure location, suitable for display on a map. Use this key for any type of boarding pass.
    public var destinationLocation: SemanticTagType.Location?

    /// A brief description of the destination location. For example, for a flight arriving at an airport whose code is “MPM,” “Maputo“ might be an appropriate description. Use this key for any type of boarding pass.
    public var destinationLocationDescription: String?

    /// The name of the destination platform, such as “A”. Don’t include the word “Platform.” Use this key only for a train or other rail boarding pass.
    public var destinationPlatform: String?

    /// The name of the destination station, such as “1st Street Station”. Use this key only for a train or other rail boarding pass.
    public var destinationStationName: String?

    /// The terminal name or letter of the destination terminal, such as “A”. Don’t include the word “Terminal.” Use this key only for airline boarding passes.
    public var destinationTerminal: String?

    /// The duration of the event or transit journey, in seconds. Use this key for any type of boarding pass and any type of event ticket.
    public var duration: Int?

    /// The date and time the event ends. Use this key for any type of event ticket.
    public var eventEndDate: Date?

    /// The full name of the event, such as the title of a movie. Use this key for any type of event ticket.
    public var eventName: String?

    /// The date and time the event starts. Use this key for any type of event ticket.
    public var eventStartDate: Date?

    /// The type of event. Use this key for any type of event ticket.
    public var eventType: EventType?

    /// The IATA flight code, such as “EX123”. Use this key only for airline boarding passes.
    public var flightCode: String?

    /// The numeric portion of the IATA flight code, such as 123 for flightCode “EX123”. Use this key only for airline boarding passes.
    public var flightNumber: Int?

    /// The genre of the performance, such as “Classical”. Use this key for any type of event ticket.
    public var genre: String?

    /// The unique abbreviation of the home team’s name. Use this key only for a sports event ticket.
    public var homeTeamAbbreviation: String?

    /// The home location of the home team. Use this key only for a sports event ticket.
    public var homeTeamLocation: String?

    /// The name of the home team. Use this key only for a sports event ticket.
    public var homeTeamName: String?

    /// The abbreviated league name for a sports event. Use this key only for a sports event ticket.
    public var leagueAbbreviation: String?

    /// The unabbreviated league name for a sports event. Use this key only for a sports event ticket.
    public var leagueName: String?

    /// The name of a frequent flyer or loyalty program. Use this key for any type of boarding pass.
    public var membershipProgramName: String?

    /// The ticketed passenger’s frequent flyer or loyalty number. Use this key for any type of boarding pass.
    public var membershipProgramNumber: String?

    /// The originally scheduled date and time of arrival. Use this key for any type of boarding pass.
    public var originalArrivalDate: Date?

    /// The originally scheduled date and time of boarding. Use this key for any type of boarding pass.
    public var originalBoardingDate: Date?

    /// The originally scheduled date and time of departure. Use this key for any type of boarding pass.
    public var originalDepartureDate: Date?

    /// An object that represents the name of the passenger. Use this key for any type of boarding pass.
    public var passengerName: SemanticTagType.PersonNameComponents?

    /// An array of the full names of the performers and opening acts at the event, in decreasing order of significance. Use this key for any type of event ticket.
    public var performerNames: [String]?

    /// The priority status the ticketed passenger holds, such as “Gold” or “Silver”. Use this key for any type of boarding pass.
    public var priorityStatus: String?

    /// An array of objects that represent the details for each seat at an event or on a transit journey. Use this key for any type of boarding pass or event ticket.
    public var seats: [SemanticTagType.Seat]?

    /// The type of security screening for the ticketed passenger, such as “Priority”. Use this key for any type of boarding pass.
    public var securityScreening: String?

    /// A Boolean value that determines whether the user’s device remains silent during an event or transit journey. The system may override the key and determine the length of the period of silence. Use this key for any type of boarding pass or event ticket.
    public var silenceRequested: Bool?

    /// The commonly used name of the sport. Use this key only for a sports event ticket.
    public var sportName: String?

    /// The total price for the pass. Use this key for any pass type.
    public var totalPrice: SemanticTagType.CurrencyAmount?

    /// The name of the transit company. Use this key for any type of boarding pass.
    public var transitProvider: String?

    /// A brief description of the current boarding status for the vessel, such as “On Time” or “Delayed”. For delayed status, provide currentBoardingDate, currentDepartureDate, and currentArrivalDate where available. Use this key for any type of boarding pass.
    public var transitStatus: String?

    /// A brief description that explains the reason for the current transitStatus, such as “Thunderstorms”. Use this key for any type of boarding pass.
    public var transitStatusReason: String?

    /// The name of the vehicle to board, such as the name of a boat. Use this key for any type of boarding pass.
    public var vehicleName: String?

    /// The identifier of the vehicle to board, such as the aircraft registration number or train number. Use this key for any type of boarding pass.
    public var vehicleNumber: String?

    /// A brief description of the type of vehicle to board, such as the model and manufacturer of a plane or the class of a boat. Use this key for any type of boarding pass.
    public var vehicleType: String?

    /// The full name of the entrance, such as “Gate A”, to use to gain access to the ticketed event. Use this key for any type of event ticket.
    public var venueEntrance: String?

    /// An object that represents the geographic coordinates of the venue. Use this key for any type of event ticket.
    public var venueLocation: SemanticTagType.Location?

    /// The full name of the venue. Use this key for any type of event ticket.
    public var venueName: String?

    /// The phone number for enquiries about the venue’s ticketed event. Use this key for any type of event ticket.
    public var venuePhoneNumber: String?

    /// The full name of the room where the ticketed event is to take place. Use this key for any type of event ticket.
    public var venueRoom: String?

    /// An array of objects that represent the WiFi networks associated with the event; for example, the network name and password associated with a developer conference. Use this key for any type of pass.
    public var wifiAccess: [SemanticTagType.WifiNetwork]?
}

extension SemanticTags {
    public enum EventType: String, Codable, Equatable, Hashable, CaseIterable {
        case generic = "PKEventTypeGeneric"
        case livePerformance = "PKEventTypeLivePerformance"
        case movie = "PKEventTypeMovie"
        case sports = "PKEventTypeSports"
        case conference = "PKEventTypeConference"
        case convention = "PKEventTypeConvention"
        case workshop = "PKEventTypeWorkshop"
        case socialGathering = "PKEventTypeSocialGathering"
    }
}

public enum SemanticTagType {
    // https://developer.apple.com/documentation/walletpasses/semantictagtype/personnamecomponents
    /// An object that represents the parts of a person’s name.
    public struct PersonNameComponents: Codable, Equatable, Hashable {
        /// The person’s family name or last name.
        public var familyName: String?

        /// The person’s given name; also called the forename or first name in some countries.
        public var givenName: String?

        /// The person’s middle name.
        public var middleName: String?

        /// The prefix for the person’s name, such as “Dr”.
        public var namePrefix: String?

        /// The suffix for the person’s name, such as “Junior”.
        public var nameSuffix: String?

        /// The person’s nickname.
        public var nickname: String?

        /// The phonetic representation of the person’s name.
        public var phoneticRepresentation: String?

        public init(
            familyName: String? = nil,
            givenName: String? = nil,
            middleName: String? = nil,
            namePrefix: String? = nil,
            nameSuffix: String? = nil,
            nickname: String? = nil,
            phoneticRepresentation: String? = nil
        ) {
            self.familyName = familyName
            self.givenName = givenName
            self.middleName = middleName
            self.namePrefix = namePrefix
            self.nameSuffix = nameSuffix
            self.nickname = nickname
            self.phoneticRepresentation = phoneticRepresentation
        }
    }

    // https://developer.apple.com/documentation/walletpasses/semantictagtype/seat
    /// An object that represents the identification of a seat for a transit journey or an event.
    public struct Seat: Codable, Equatable, Hashable {
        /// A description of the seat, such as “A flat bed seat”.
        public var seatDescription: String?

        /// The identifier code for the seat.
        public var seatIdentifier: String?

        /// The number of the seat.
        public var seatNumber: String?

        /// The row that contains the seat.
        public var seatRow: String?

        /// The section that contains the seat.
        public var seatSection: String?

        /// The type of seat, such as “Reserved seating”.
        public var seatType: String?

        public init(
            seatDescription: String? = nil,
            seatIdentifier: String? = nil,
            seatNumber: String? = nil,
            seatRow: String? = nil,
            seatSection: String? = nil,
            seatType: String? = nil
        ) {
            self.seatDescription = seatDescription
            self.seatIdentifier = seatIdentifier
            self.seatNumber = seatNumber
            self.seatRow = seatRow
            self.seatSection = seatSection
            self.seatType = seatType
        }
    }

    // https://developer.apple.com/documentation/walletpasses/semantictagtype/currencyamount
    /// An object that represents an amount of money and type of currency.
    public struct CurrencyAmount: Codable, Equatable, Hashable {
        /// The amount of money.
        public var amount: String?

        /// The ISO 4217 currency code for amount.
        public var currencyCode: String?

        public init(
            amount: String? = nil,
            currencyCode: String? = nil
        ) {
            self.amount = amount
            self.currencyCode = currencyCode
        }
    }

    // https://developer.apple.com/documentation/walletpasses/semantictagtype/location
    /// An object that represents the coordinates of a location.
    public struct Location: Codable, Equatable, Hashable {
        /// The latitude, in degrees.
        public var latitude: Double

        /// The longitude, in degrees.
        public var longitude: Double

        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }

    // https://developer.apple.com/documentation/walletpasses/semantictagtype/wifinetwork
    /// An object that contains information required to connect to a WiFi network.
    public struct WifiNetwork: Codable, Equatable, Hashable {
        /// The password for the WiFi network.
        public var password: String

        /// The name for the WiFi network.
        public var ssid: String

        public init(
            password: String,
            ssid: String
        ) {
            self.password = password
            self.ssid = ssid
        }
    }
}
