// PassLocation.swift
// Copyright © 2022 hiimtmac

import Foundation

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/LowerLevel.html#//apple_ref/doc/uid/TP40012026-CH3-SW2
/// Information about a location
public struct PassLocation: Codable {
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
