// PassBeacon.swift
// Copyright © 2022 hiimtmac

import Foundation

// https://developer.apple.com/library/archive/documentation/UserExperience/Reference/PassKit_Bundle/Chapters/LowerLevel.html#//apple_ref/doc/uid/TP40012026-CH3-SW4
/// Information about a location beacon
///
///  - Note: Available in iOS 7.0
public struct PassBeacon: Codable {
    /// Major identifier of a Bluetooth Low Energy location beacon.
    public var major: UInt16?
    /// Minor identifier of a Bluetooth Low Energy location beacon.
    public var minor: UInt16?
    /// Unique identifier of a Bluetooth Low Energy location beacon.
    public var proximityUUID: String
    /// Text displayed on the lock screen when the pass is currently relevant. For example, a description of the nearby location such as “Store nearby on 1st and Main.”
    public var relevantText: String?

    /// Information about a location beacon
    /// - Parameters:
    ///   - major: Major identifier of a Bluetooth Low Energy location beacon
    ///   - minor: Minor identifier of a Bluetooth Low Energy location beacon
    ///   - proximityUUID: Unique identifier of a Bluetooth Low Energy location beacon
    ///   - relevantText: Text displayed on the lock screen when the pass is currently relevant
    public init(
        major: UInt16? = nil,
        minor: UInt16? = nil,
        proximityUUID: String,
        relevantText: String? = nil
    ) {
        self.major = major
        self.minor = minor
        self.proximityUUID = proximityUUID
        self.relevantText = relevantText
    }
}
