// Location.swift
// Copyright (c) 2025 hiimtmac inc.

// https://developer.apple.com/documentation/walletpasses/pass/locations
extension Pass {
    /// Information about a location
    public struct Location: Codable, Equatable, Hashable, Sendable {
        /// Altitude, in meters, of the location.
        public var altitude: Double?

        /// Latitude, in degrees, of the location.
        public var latitude: Double

        /// Longitude, in degrees, of the location.
        public var longitude: Double

        /// Text displayed on the lock screen when the pass is currently relevant. For example, a description of the nearby location such as “Store nearby on 1st and Main.”
        public var relevantText: String?

        /// Information about a location
        /// - Parameters:
        ///   - altitude: Altitude, in meters, of the location
        ///   - latitude: Latitude, in degrees, of the location
        ///   - longitude: Longitude, in degrees, of the location
        ///   - relevantText: Text displayed on the lock screen when the pass is currently relevant
        public init(
            altitude: Double? = nil,
            latitude: Double,
            longitude: Double,
            relevantText: String? = nil
        ) {
            self.altitude = altitude
            self.latitude = latitude
            self.longitude = longitude
            self.relevantText = relevantText
        }
    }
}
