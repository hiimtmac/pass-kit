// SemanticTags.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation

// https://developer.apple.com/documentation/walletpasses/semantictags

public struct SemanticTags: Codable, Equatable, Hashable, Sendable {
    /// Additional ticket attributes that other tags or keys in the pass don’t include.
    ///
    /// Use this key for any type of event ticket.
    public var additionalTicketAttributes: String?

    /// The level of admission the ticket provides, such as general admission, VIP, and so forth.
    ///
    /// Use this key for any type of event ticket.
    public var admissionLevel: String?

    /// An abbreviation of the level of admission the ticket provides, such as GA or VIP.
    ///
    /// Use this key for any type of event ticket.
    public var admissionLevelAbbreviation: String?

    /// The IATA airline code, such as “EX” for flightCode “EX123”.
    ///
    /// Use this key only for airline boarding passes.
    public var airlineCode: String?
    
    /// A MapKit Place ID that references the airline lounge location.
    ///
    /// For more information see [Identifying unique locations with Place IDs.](https://developer.apple.com/documentation/MapKit/identifying-unique-locations-with-place-ids)
    public var airlineLoungePlaceID: String?
    
    /// A list of airline specific capabilties the passenger has. Only use this key for airline boarding passes.
    public var airlinePassengerCapabilities: [AirlinePassengerCapability]?

    /// An array of the Apple Music persistent ID for each album corresponding to the event, in decreasing order of significance.
    ///
    /// Use this key for any type of event ticket.
    public var albumIDs: [String]?

    /// An array of the Apple Music persistent ID for each artist performing at the event, in decreasing order of significance.
    ///
    /// Use this key for any type of event ticket.
    public var artistIDs: [String]?

    /// The name of the person the ticket grants admission to.
    ///
    /// Use this key for any type of event ticket.
    public var attendeeName: String?

    /// The unique abbreviation of the away team’s name.
    ///
    /// Use this key only for a sports event ticket.
    public var awayTeamAbbreviation: String?

    /// The home location of the away team.
    ///
    /// Use this key only for a sports event ticket.
    public var awayTeamLocation: String?

    /// The name of the away team.
    ///
    /// Use this key only for a sports event ticket.
    public var awayTeamName: String?

    /// The current balance redeemable with the pass.
    ///
    /// Use this key only for a store card pass.
    public var balance: SemanticTagType.CurrencyAmount?

    /// A group number for boarding.
    ///
    /// Use this key for any type of boarding pass.
    public var boardingGroup: String?

    /// A sequence number for boarding.
    ///
    /// Use this key for any type of boarding pass.
    public var boardingSequenceNumber: String?
    
    /// A zone number for boarding. Don’t include the word zone.
    public var boardingZone: String?

    /// The number of the passenger car.
    ///
    /// A train car is also called a carriage, wagon, coach, or bogie in some countries.
    ///
    /// Use this key only for a train or other rail boarding pass.
    public var carNumber: String?

    /// A booking or reservation confirmation number.
    ///
    /// Use this key for any type of boarding pass.
    public var confirmationNumber: String?

    /// The updated date and time of arrival, if different from the originally scheduled date and time.
    ///
    /// Use this key for any type of boarding pass.
    public var currentArrivalDate: Date?

    /// The updated date and time of boarding, if different from the originally scheduled date and time.
    ///
    /// Use this key for any type of boarding pass.
    public var currentBoardingDate: Date?

    /// The updated departure date and time, if different from the originally scheduled date and time.
    ///
    /// Use this key for any type of boarding pass.
    public var currentDepartureDate: Date?

    /// The IATA airport code for the departure airport, such as “MPM” or “LHR”.
    ///
    /// Use this key only for airline boarding passes.
    public var departureAirportCode: String?

    /// The full name of the departure airport, such as “Maputo International Airport”.
    ///
    /// Use this key only for airline boarding passes.
    public var departureAirportName: String?
    
    /// A list of security programs that exist in the departure airport.
    ///
    /// This only shows in the UI if a program is in passengerEligibleSecurityPrograms and at least one of departureAirportSecurityPrograms or destinationAirportSecurityPrograms.
    public var departureAirportSecurityPrograms: [AirportSecurityProgram]?
    
    /// The time zone for the distination airport, such as America/LosAngeles.
    public var depatureAirportTimeZone: String?

    // The name of the destination city to display on the boarding pass, such as London or Shanghai.
    public var departureCityName: String?
    
    /// The gate number or letters of the departure gate, such as “1A”.
    ///
    /// Do not include the word “Gate.”
    public var departureGate: String?

    /// An object that represents the geographic coordinates of the transit departure location, suitable for display on a map. If possible, use precise locations, which are more useful to travelers; for example, the specific location of an airport gate.
    ///
    /// Use this key for any type of boarding pass.
    public var departureLocation: SemanticTagType.Location?

    /// A brief description of the departure location. For example, for a flight departing from an airport whose code is “LHR,” an appropriate description might be “London, Heathrow“.
    ///
    /// Use this key for any type of boarding pass.
    public var departureLocationDescription: String?

    /// The name of the departure platform, such as “A”. Don’t include the word “Platform.”
    ///
    /// Use this key only for a train or other rail boarding pass.
    public var departurePlatform: String?

    /// The name of the departure station, such as “1st Street Station”.
    ///
    /// Use this key only for a train or other rail boarding pass.
    public var departureStationName: String?

    /// The name or letter of the departure terminal, such as “A”. Don’t include the word “Terminal.”
    ///
    /// Use this key only for airline boarding passes.
    public var departureTerminal: String?

    /// The IATA airport code for the destination airport, such as “MPM” or “LHR”.
    ///
    /// Use this key only for airline boarding passes.
    public var destinationAirportCode: String?

    /// The full name of the destination airport, such as “London Heathrow”.
    ///
    /// Use this key only for airline boarding passes.
    public var destinationAirportName: String?
    
    /// A list of security programs that exist in the destination airport.
    ///
    /// This only shows in the UI if a program is in passengerEligibleSecurityPrograms and at least one of departureAirportSecurityPrograms or destinationAirportSecurityPrograms.
    public var destinationAirportSecurityPrograms: [AirportSecurityProgram]?
    
    /// The time zone for the destination airport, such as America/Los_Angeles.
    ///
    /// See the [IANA Time Zone Database](https://www.iana.org/time-zones) for the full list of supported time zones.
    public var destinationAirportTimeZone: String?
    
    /// The name of the destination city to display on the boarding pass, such as London or Shanghai.
    public var destinationCityName: String?

    /// The gate number or letter of the destination gate, such as “1A”. Don’t include the word “Gate.”
    ///
    /// Use this key only for airline boarding passes.
    public var destinationGate: String?

    /// An object that represents the geographic coordinates of the transit departure location, suitable for display on a map.
    ///
    /// Use this key for any type of boarding pass.
    public var destinationLocation: SemanticTagType.Location?

    /// A brief description of the destination location. For example, for a flight arriving at an airport whose code is “MPM,” “Maputo“ might be an appropriate description.
    ///
    /// Use this key for any type of boarding pass.
    public var destinationLocationDescription: String?

    /// The name of the destination platform, such as “A”. Don’t include the word “Platform.”
    ///
    /// Use this key only for a train or other rail boarding pass.
    public var destinationPlatform: String?

    /// The name of the destination station, such as “1st Street Station”.
    ///
    /// Use this key only for a train or other rail boarding pass.
    public var destinationStationName: String?

    /// The terminal name or letter of the destination terminal, such as “A”. Don’t include the word “Terminal.”
    ///
    /// Use this key only for airline boarding passes.
    public var destinationTerminal: String?

    /// The duration of the event or transit journey, in seconds.
    ///
    /// Use this key for any type of boarding pass and any type of event ticket.
    public var duration: Int?

    /// The long description of the entrance information.
    ///
    /// Use this key for any type of event ticket.
    public var entranceDescription: String?

    /// The date and time the event ends.
    ///
    /// Use this key for any type of event ticket.
    public var eventEndDate: Date?

    /// The full name of the event, such as the title of a movie.
    ///
    /// Use this key for any type of event ticket.
    public var eventName: String?

    /// The date and time the event starts.
    ///
    /// Use this key for any type of event ticket.
    public var eventStartDate: Date?

    /// An object that provides information for the date and time the event starts.
    ///
    /// Use this key for any type of event ticket.
    public var eventStartDateInfo: SemanticTagType.EventDateInfo?

    /// The type of event.
    ///
    /// Use this key for any type of event ticket.
    public var eventType: EventType?

    /// The IATA flight code, such as “EX123”.
    ///
    /// Use this key only for airline boarding passes.
    public var flightCode: String?

    /// The numeric portion of the IATA flight code, such as 123 for flightCode “EX123”.
    ///
    /// Use this key only for airline boarding passes.
    public var flightNumber: Int?

    /// The genre of the performance, such as “Classical”.
    ///
    /// Use this key for any type of event ticket.
    public var genre: String?

    /// The unique abbreviation of the home team’s name.
    ///
    /// Use this key only for a sports event ticket.
    public var homeTeamAbbreviation: String?

    /// The home location of the home team.
    ///
    /// Use this key only for a sports event ticket.
    public var homeTeamLocation: String?

    /// The name of the home team.
    ///
    /// Use this key only for a sports event ticket.
    public var homeTeamName: String?
    
    /// An optional boolean that indicates whether the passenger’s international documents are verified.
    ///
    /// If set to true Wallet displays the badge on the boarding pass with the value from `internationalDocumentsVerifiedDeclarationName`.
    public var internationalDocumentsAreVerified: Bool?
    
    /// The name of the declaration given once the passenger’s international documents are verified.
    ///
    /// Examples include DOCS OK or Travel Ready. If `internationalDocumentsAreVerified` is true, Wallet displays a badge on the boarding pass with this value.
    public var internationalDocumentsVerifiedDeclarationName: String?

    /// The abbreviated league name for a sports event.
    ///
    /// Use this key only for a sports event ticket.
    public var leagueAbbreviation: String?

    /// The unabbreviated league name for a sports event.
    ///
    /// Use this key only for a sports event ticket.
    public var leagueName: String?

    /// The name of a frequent flyer or loyalty program.
    ///
    /// Use this key for any type of boarding pass.
    public var membershipProgramName: String?

    /// The ticketed passenger’s frequent flyer or loyalty number.
    ///
    /// Use this key for any type of boarding pass.
    public var membershipProgramNumber: String?

    /// The originally scheduled date and time of arrival.
    ///
    /// Use this key for any type of boarding pass.
    public var originalArrivalDate: Date?

    /// The originally scheduled date and time of boarding.
    ///
    /// Use this key for any type of boarding pass.
    public var originalBoardingDate: Date?

    /// The originally scheduled date and time of departure.
    ///
    /// Use this key for any type of boarding pass.
    public var originalDepartureDate: Date?
    
    /// An array of airline-specific SSRs that apply to the ticketed passenger.
    public var passengerAirlineSSRs: String?
    
    /// An array of IATA information SSRs that apply to the ticketed passenger.
    ///
    /// A comprehensive list of service SSRs can be found in the [the IATA Airlines Developer Guide](https://guides.developer.iata.org/docs/21-1_ImplementationGuide.pdf) under A List of Information SSRs.
    public var passengerInformationSSRs: String?

    /// An object that represents the name of the passenger.
    ///
    /// Use this key for any type of boarding pass.
    public var passengerName: SemanticTagType.PersonNameComponents?
    
    /// An array of IATA information SSRs that apply to the ticketed passenger.
    ///
    /// A comprehensive list of service SSRs can be found in the [the IATA Airlines Developer Guide](https://guides.developer.iata.org/docs/21-1_ImplementationGuide.pdf) under A List of Service SSRs.
    public var passengerServiceSSRs: String?

    /// An array of the full names of the performers and opening acts at the event, in decreasing order of significance.
    ///
    /// Use this key for any type of event ticket.
    public var performerNames: [String]?

    /// An array of the Apple Music persistent ID for each playlist corresponding to the event, in decreasing order of significance.
    ///
    /// Use this key for any type of event ticket.
    public var playlistIDs: [String]?

    /// The priority status the ticketed passenger holds, such as “Gold” or “Silver”.
    ///
    /// Use this key for any type of boarding pass.
    public var priorityStatus: String?

    /// An array of objects that represent the details for each seat at an event or on a transit journey.
    ///
    /// Use this key for any type of boarding pass or event ticket.
    public var seats: [SemanticTagType.Seat]?

    /// The type of security screening for the ticketed passenger, such as “Priority”.
    ///
    /// Use this key for any type of boarding pass.
    public var securityScreening: String?

    /// A Boolean value that determines whether the user’s device remains silent during an event or transit journey.
    ///
    /// The system may override the key and determine the length of the period of silence.
    ///
    /// Use this key for any type of boarding pass or event ticket.
    public var silenceRequested: Bool?

    /// The commonly used name of the sport.
    ///
    /// Use this key only for a sports event ticket.
    public var sportName: String?

    /// A Boolean value that indicates whether tailgating is allowed at the event.
    ///
    /// Use this key for any type of event ticket.
    public var tailgaitingAllowed: Bool?
    
    /// A localizable string that denotes the ticket class, such as Saver, Economy, First.
    ///
    /// This value displays as a badge on the boarding pass.
    public var ticketFareClass: String?

    /// The total price for the pass.
    ///
    /// Use this key for any pass type.
    public var totalPrice: SemanticTagType.CurrencyAmount?

    /// The name of the transit company.
    ///
    /// Use this key for any type of boarding pass.
    public var transitProvider: String?

    /// A brief description of the current boarding status for the vessel, such as “On Time” or “Delayed”.
    ///
    /// For delayed status, provide ``currentBoardingDate``, ``currentDepartureDate``, and ``currentArrivalDate`` where available.
    ///
    /// Use this key for any type of boarding pass.
    public var transitStatus: String?

    /// A brief description that explains the reason for the current transitStatus, such as “Thunderstorms”.
    ///
    /// Use this key for any type of boarding pass.
    public var transitStatusReason: String?

    /// The name of the vehicle to board, such as the name of a boat.
    ///
    /// Use this key for any type of boarding pass.
    public var vehicleName: String?

    /// The identifier of the vehicle to board, such as the aircraft registration number or train number.
    ///
    /// Use this key for any type of boarding pass.
    public var vehicleNumber: String?

    /// A brief description of the type of vehicle to board, such as the model and manufacturer of a plane or the class of a boat.
    ///
    /// Use this key for any type of boarding pass.
    public var vehicleType: String?

    /// The date when the box office opens.
    ///
    /// Use this key for any type of event ticket.
    public var venueBoxOfficeOpenDate: Date?

    /// The date when the venue closes.
    ///
    /// Use this key for any type of event ticket.
    public var venueCloseDate: Date?

    /// The date the doors to the venue open.
    ///
    /// Use this key for any type of event ticket.
    public var venueDoorsOpenDate: Date?

    /// The full name of the entrance, such as “Gate A”, to use to gain access to the ticketed event.
    ///
    /// Use this key for any type of event ticket.
    public var venueEntrance: String?

    /// The venue entrance door.
    ///
    /// Use this key for any type of event ticket.
    public var venueEntranceDoor: String?

    /// The venue entrance gate.
    ///
    /// Use this key for any type of event ticket.
    public var venueEntranceGate: String?

    /// The venue entrance portal.
    ///
    /// Use this key for any type of event ticket.
    public var venueEntrancePortal: String?

    /// The date the fan zone opens.
    ///
    /// Use this key for any type of event ticket.
    public var venueFanZoneOpenDate: Date?

    /// The date the gates to the venue open.
    ///
    /// Use this key for any type of event ticket.
    public var venueGatesOpenDate: Date?

    /// An object that represents the geographic coordinates of the venue.
    ///
    /// Use this key for any type of event ticket.
    public var venueLocation: SemanticTagType.Location?

    /// The full name of the venue.
    ///
    /// Use this key for any type of event ticket.
    public var venueName: String?

    /// The date when the venue opens.
    ///
    /// Use this if none of the more specific venue open tags apply.
    ///
    /// Use this key for any type of event ticket.
    public var venueOpenDate: Date?

    /// The date the parking lots open.
    ///
    /// Use this key for any type of event ticket.
    public var venueParkingLotsOpenDate: Date?

    /// The phone number for enquiries about the venue’s ticketed event.
    ///
    /// Use this key for any type of event ticket.
    public var venuePhoneNumber: String?

    /// The name of the city or hosting region of the venue.
    ///
    /// Use this key for any type of event ticket.
    public var venueRegionName: String?

    /// The full name of the room where the ticketed event is to take place.
    ///
    /// Use this key for any type of event ticket.
    public var venueRoom: String?

    /// An array of objects that represent the WiFi networks associated with the event; for example, the network name and password associated with a developer conference.
    ///
    /// Use this key for any type of pass.
    public var wifiAccess: [SemanticTagType.WifiNetwork]?

    public init(
        additionalTicketAttributes: String? = nil,
        admissionLevel: String? = nil,
        admissionLevelAbbreviation: String? = nil,
        airlineCode: String? = nil,
        airlineLoungePlaceID: String? = nil,
        airlinePassengerCapabilities: [AirlinePassengerCapability]? = nil,
        albumIDs: [String]? = nil,
        artistIDs: [String]? = nil,
        attendeeName: String? = nil,
        awayTeamAbbreviation: String? = nil,
        awayTeamLocation: String? = nil,
        awayTeamName: String? = nil,
        balance: SemanticTagType.CurrencyAmount? = nil,
        boardingGroup: String? = nil,
        boardingSequenceNumber: String? = nil,
        boardingZone: String? = nil,
        carNumber: String? = nil,
        confirmationNumber: String? = nil,
        currentArrivalDate: Date? = nil,
        currentBoardingDate: Date? = nil,
        currentDepartureDate: Date? = nil,
        departureAirportCode: String? = nil,
        departureAirportName: String? = nil,
        departureAirportSecurityPrograms: [AirportSecurityProgram]? = nil,
        depatureAirportTimeZone: String? = nil,
        departureCityName: String? = nil,
        departureGate: String? = nil,
        departureLocation: SemanticTagType.Location? = nil,
        departureLocationDescription: String? = nil,
        departurePlatform: String? = nil,
        departureStationName: String? = nil,
        departureTerminal: String? = nil,
        destinationAirportCode: String? = nil,
        destinationAirportName: String? = nil,
        destinationAirportSecurityPrograms: [AirportSecurityProgram]? = nil,
        destinationAirportTimeZone: String? = nil,
        destinationCityName: String? = nil,
        destinationGate: String? = nil,
        destinationLocation: SemanticTagType.Location? = nil,
        destinationLocationDescription: String? = nil,
        destinationPlatform: String? = nil,
        destinationStationName: String? = nil,
        destinationTerminal: String? = nil,
        duration: Int? = nil,
        entranceDescription: String? = nil,
        eventEndDate: Date? = nil,
        eventName: String? = nil,
        eventStartDate: Date? = nil,
        eventStartDateInfo: SemanticTagType.EventDateInfo? = nil,
        eventType: EventType? = nil,
        flightCode: String? = nil,
        flightNumber: Int? = nil,
        genre: String? = nil,
        homeTeamAbbreviation: String? = nil,
        homeTeamLocation: String? = nil,
        homeTeamName: String? = nil,
        internationalDocumentsAreVerified: Bool? = nil,
        internationalDocumentsVerifiedDeclarationName: String? = nil,
        leagueAbbreviation: String? = nil,
        leagueName: String? = nil,
        membershipProgramName: String? = nil,
        membershipProgramNumber: String? = nil,
        originalArrivalDate: Date? = nil,
        originalBoardingDate: Date? = nil,
        originalDepartureDate: Date? = nil,
        passengerAirlineSSRs: String? = nil,
        passengerInformationSSRs: String? = nil,
        passengerName: SemanticTagType.PersonNameComponents? = nil,
        passengerServiceSSRs: String? = nil,
        performerNames: [String]? = nil,
        playlistIDs: [String]? = nil,
        priorityStatus: String? = nil,
        seats: [SemanticTagType.Seat]? = nil,
        securityScreening: String? = nil,
        silenceRequested: Bool? = nil,
        sportName: String? = nil,
        tailgaitingAllowed: Bool? = nil,
        ticketFareClass: String? = nil,
        totalPrice: SemanticTagType.CurrencyAmount? = nil,
        transitProvider: String? = nil,
        transitStatus: String? = nil,
        transitStatusReason: String? = nil,
        vehicleName: String? = nil,
        vehicleNumber: String? = nil,
        vehicleType: String? = nil,
        venueBoxOfficeOpenDate: Date? = nil,
        venueCloseDate: Date? = nil,
        venueDoorsOpenDate: Date? = nil,
        venueEntrance: String? = nil,
        venueEntranceDoor: String? = nil,
        venueEntranceGate: String? = nil,
        venueEntrancePortal: String? = nil,
        venueFanZoneOpenDate: Date? = nil,
        venueGatesOpenDate: Date? = nil,
        venueLocation: SemanticTagType.Location? = nil,
        venueName: String? = nil,
        venueOpenDate: Date? = nil,
        venueParkingLotsOpenDate: Date? = nil,
        venuePhoneNumber: String? = nil,
        venueRegionName: String? = nil,
        venueRoom: String? = nil,
        wifiAccess: [SemanticTagType.WifiNetwork]? = nil
    ) {
        self.additionalTicketAttributes = additionalTicketAttributes
        self.admissionLevel = admissionLevel
        self.admissionLevelAbbreviation = admissionLevelAbbreviation
        self.airlineCode = airlineCode
        self.airlineLoungePlaceID = airlineLoungePlaceID
        self.airlinePassengerCapabilities = airlinePassengerCapabilities
        self.albumIDs = albumIDs
        self.artistIDs = artistIDs
        self.attendeeName = attendeeName
        self.awayTeamAbbreviation = awayTeamAbbreviation
        self.awayTeamLocation = awayTeamLocation
        self.awayTeamName = awayTeamName
        self.balance = balance
        self.boardingGroup = boardingGroup
        self.boardingSequenceNumber = boardingSequenceNumber
        self.boardingZone = boardingZone
        self.carNumber = carNumber
        self.confirmationNumber = confirmationNumber
        self.currentArrivalDate = currentArrivalDate
        self.currentBoardingDate = currentBoardingDate
        self.currentDepartureDate = currentDepartureDate
        self.departureAirportCode = departureAirportCode
        self.departureAirportName = departureAirportName
        self.departureAirportSecurityPrograms = departureAirportSecurityPrograms
        self.depatureAirportTimeZone = depatureAirportTimeZone
        self.departureCityName = departureCityName
        self.departureGate = departureGate
        self.departureLocation = departureLocation
        self.departureLocationDescription = departureLocationDescription
        self.departurePlatform = departurePlatform
        self.departureStationName = departureStationName
        self.departureTerminal = departureTerminal
        self.destinationAirportCode = destinationAirportCode
        self.destinationAirportName = destinationAirportName
        self.destinationAirportSecurityPrograms = destinationAirportSecurityPrograms
        self.destinationAirportTimeZone = destinationAirportTimeZone
        self.destinationCityName = destinationCityName
        self.destinationGate = destinationGate
        self.destinationLocation = destinationLocation
        self.destinationLocationDescription = destinationLocationDescription
        self.destinationPlatform = destinationPlatform
        self.destinationStationName = destinationStationName
        self.destinationTerminal = destinationTerminal
        self.duration = duration
        self.entranceDescription = entranceDescription
        self.eventEndDate = eventEndDate
        self.eventName = eventName
        self.eventStartDate = eventStartDate
        self.eventStartDateInfo = eventStartDateInfo
        self.eventType = eventType
        self.flightCode = flightCode
        self.flightNumber = flightNumber
        self.genre = genre
        self.homeTeamAbbreviation = homeTeamAbbreviation
        self.homeTeamLocation = homeTeamLocation
        self.homeTeamName = homeTeamName
        self.internationalDocumentsAreVerified = internationalDocumentsAreVerified
        self.internationalDocumentsVerifiedDeclarationName = internationalDocumentsVerifiedDeclarationName
        self.leagueAbbreviation = leagueAbbreviation
        self.leagueName = leagueName
        self.membershipProgramName = membershipProgramName
        self.membershipProgramNumber = membershipProgramNumber
        self.originalArrivalDate = originalArrivalDate
        self.originalBoardingDate = originalBoardingDate
        self.originalDepartureDate = originalDepartureDate
        self.passengerAirlineSSRs = passengerAirlineSSRs
        self.passengerInformationSSRs = passengerInformationSSRs
        self.passengerName = passengerName
        self.passengerServiceSSRs = passengerServiceSSRs
        self.performerNames = performerNames
        self.playlistIDs = playlistIDs
        self.priorityStatus = priorityStatus
        self.seats = seats
        self.securityScreening = securityScreening
        self.silenceRequested = silenceRequested
        self.sportName = sportName
        self.tailgaitingAllowed = tailgaitingAllowed
        self.ticketFareClass = ticketFareClass
        self.totalPrice = totalPrice
        self.transitProvider = transitProvider
        self.transitStatus = transitStatus
        self.transitStatusReason = transitStatusReason
        self.vehicleName = vehicleName
        self.vehicleNumber = vehicleNumber
        self.vehicleType = vehicleType
        self.venueBoxOfficeOpenDate = venueBoxOfficeOpenDate
        self.venueCloseDate = venueCloseDate
        self.venueDoorsOpenDate = venueDoorsOpenDate
        self.venueEntrance = venueEntrance
        self.venueEntranceDoor = venueEntranceDoor
        self.venueEntranceGate = venueEntranceGate
        self.venueEntrancePortal = venueEntrancePortal
        self.venueFanZoneOpenDate = venueFanZoneOpenDate
        self.venueGatesOpenDate = venueGatesOpenDate
        self.venueLocation = venueLocation
        self.venueName = venueName
        self.venueOpenDate = venueOpenDate
        self.venueParkingLotsOpenDate = venueParkingLotsOpenDate
        self.venuePhoneNumber = venuePhoneNumber
        self.venueRegionName = venueRegionName
        self.venueRoom = venueRoom
        self.wifiAccess = wifiAccess
    }
}

extension SemanticTags {
    public enum EventType: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case generic = "PKEventTypeGeneric"
        case livePerformance = "PKEventTypeLivePerformance"
        case movie = "PKEventTypeMovie"
        case sports = "PKEventTypeSports"
        case conference = "PKEventTypeConference"
        case convention = "PKEventTypeConvention"
        case workshop = "PKEventTypeWorkshop"
        case socialGathering = "PKEventTypeSocialGathering"
    }
    
    public enum AirlinePassengerCapability: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case preboarding = "PKAirlinePassengerCapabilityPreboarding"
        case priorityBoarding = "PKAirlinePassengerCapabilityPriorityBoarding"
        case carryon = "PKAirlinePassengerCapabilityCarryon"
        case personalItem = "PKAirlinePassengerCapabilityPersonalItem"
    }
    
    public enum AirportSecurityProgram: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case tsaPrecheck = "PKAirportSecurityProgramTSAPreCheck"
        case tsaPrecheckTouchessId = "PKAirportSecurityProgramTSAPreCheckTouchlessID"
        case oss = "PKAirportSecurityProgramOSS"
        case iti = "PKAirportSecurityProgramITI"
        case itd = "PKAirportSecurityProgramITD"
        case globalEntry = "PKAirportSecurityProgramGlobalEntry"
        case clear = "PKAirportSecurityProgramCLEAR"
    }
}

public enum SemanticTagType {
    // https://developer.apple.com/documentation/walletpasses/semantictagtype/eventdateinfo-data.dictionary
    /// An object that represents a date for an event.
    public struct EventDateInfo: Codable, Equatable, Hashable, Sendable {
        /// The date.
        public var date: Date?

        /// A Boolean value that indicates whether the system ignores the time components of the date.
        public var ignoreTimeComponents: Bool?

        /// The time zone database identifier to display in the date.
        public var timeZone: String?

        /// A Boolean value that indicates whether the date of the event is announced.
        public var unannounced: Bool?

        /// A Boolean value that indicates whether the date of the event is determined.
        public var undetermined: Bool?

        public init(
            date: Date? = nil,
            ignoreTimeComponents: Bool? = nil,
            timeZone: String? = nil,
            unannounced: Bool? = nil,
            undetermined: Bool? = nil
        ) {
            self.date = date
            self.ignoreTimeComponents = ignoreTimeComponents
            self.timeZone = timeZone
            self.unannounced = unannounced
            self.undetermined = undetermined
        }
    }

    // https://developer.apple.com/documentation/walletpasses/semantictagtype/personnamecomponents-data.dictionary
    /// An object that represents the parts of a person’s name.
    public struct PersonNameComponents: Codable, Equatable, Hashable, Sendable {
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

    // https://developer.apple.com/documentation/walletpasses/semantictagtype/seat-data.dictionary
    /// An object that represents the identification of a seat for a transit journey or an event.
    public struct Seat: Codable, Equatable, Hashable, Sendable {
        /// The aisle that contains the seat.
        public var seatAisle: String?

        /// A description of the seat, such as “A flat bed seat”.
        public var seatDescription: String?

        /// The identifier code for the seat.
        public var seatIdentifier: String?

        /// The level that contains the seat.
        public var seatLevel: String?

        /// The number of the seat.
        public var seatNumber: String?

        /// The row that contains the seat.
        public var seatRow: String?

        /// The section that contains the seat.
        public var seatSection: String?

        /// A color associated with identifying the seat, specified as a CSS-style RGB triple, such as rgb(23, 187, 82).
        public var seatSectionColor: PassColor?

        /// The type of seat, such as “Reserved seating”.
        public var seatType: String?

        public init(
            seatAisle: String? = nil,
            seatDescription: String? = nil,
            seatIdentifier: String? = nil,
            seatLevel: String? = nil,
            seatNumber: String? = nil,
            seatRow: String? = nil,
            seatSection: String? = nil,
            seatSectionColor: PassColor? = nil,
            seatType: String? = nil
        ) {
            self.seatAisle = seatAisle
            self.seatDescription = seatDescription
            self.seatIdentifier = seatIdentifier
            self.seatLevel = seatLevel
            self.seatNumber = seatNumber
            self.seatRow = seatRow
            self.seatSection = seatSection
            self.seatSectionColor = seatSectionColor
            self.seatType = seatType
        }
    }

    // https://developer.apple.com/documentation/walletpasses/semantictagtype/currencyamount
    /// An object that represents an amount of money and type of currency.
    public struct CurrencyAmount: Codable, Equatable, Hashable, Sendable {
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
    public struct Location: Codable, Equatable, Hashable, Sendable {
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
    public struct WifiNetwork: Codable, Equatable, Hashable, Sendable {
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
