//
//  File.swift
//  PassKit
//
//  Created by Taylor McIntyre on 2024-10-31.
//

import Foundation

extension Pass {
    public enum PreferredStyleScheme: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case posterEventTicket
        case eventTicket
    }
}
