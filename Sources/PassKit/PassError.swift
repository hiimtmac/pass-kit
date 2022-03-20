// PassError.swift
// Copyright © 2022 hiimtmac

import Foundation

enum PassError: Error {
    case nonEmptyDirectory
    case passWrite
    case manifestWrite
}

extension PassError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .nonEmptyDirectory: return "target pass directory has contents in it"
        case .passWrite: return "pass.json failed to write"
        case .manifestWrite: return "manifest.json failed to write"
        }
    }
}
