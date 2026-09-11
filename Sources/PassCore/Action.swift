// Action.swift
// Copyright (c) 2026 hiimtmac inc.

#if canImport(FoundationEssentials)
public import FoundationEssentials
#else
public import Foundation
#endif

extension Pass {
    /// An object that represents a featured action on a pass.
    public struct Action: Codable, Equatable, Hashable, Sendable {
        /// (Required) A unique identifier for the action.
        ///
        /// The identifier needs to be unique within the pass. The system uses it to tell the pass’s actions apart.
        public var identifier: String

        /// (Required) The action type to perform.
        public var type: ActionType

        /// The URL the action opens, if applicable.
        public var url: URL?

        /// An object that represents a featured action on a pass.
        /// - Parameters:
        ///   - identifier: A unique identifier for the action.
        ///   - type: The action type to perform.
        ///   - url: The URL the action opens, if applicable.
        public init(
            identifier: String,
            type: ActionType,
            url: URL? = nil
        ) {
            self.identifier = identifier
            self.type = type
            self.url = url
        }
    }
}

extension Pass.Action {
    /// The action a featured action performs.
    public enum ActionType: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case viewSchedule
        case watchTrailer
        case listenToMusic
        case call
        case place
        case addToBalance
        case order
        case shop
        case membershipBenefits
        case bookAppointment
        case bookCar
        case bookFlight
        case bookStay
        case viewOffersRewards
    }
}
