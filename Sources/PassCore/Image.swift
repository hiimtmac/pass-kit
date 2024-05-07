// Image.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation

public struct Image {
    public let type: ImageType
    public let scale: ImageScale

    public init(type: ImageType, scale: ImageScale) {
        self.type = type
        self.scale = scale
    }

    public static func icon(_ scale: ImageScale) -> Self {
        .init(type: .icon, scale: scale)
    }

    public static func logo(_ scale: ImageScale) -> Self {
        .init(type: .logo, scale: scale)
    }

    public static func thumbnail(_ scale: ImageScale) -> Self {
        .init(type: .thumbnail, scale: scale)
    }

    public static func strip(_ scale: ImageScale) -> Self {
        .init(type: .strip, scale: scale)
    }

    public static func background(_ scale: ImageScale) -> Self {
        .init(type: .background, scale: scale)
    }

    public static func footer(_ scale: ImageScale) -> Self {
        .init(type: .footer, scale: scale)
    }

    public var filename: String { "\(type.rawValue)\(scale.rawValue).png" }
}

public enum ImageType: String {
    case icon
    case logo
    case thumbnail
    case strip
    case background
    case footer
    case personalization = "personalizationLogo"
}

public enum ImageScale: String {
    case x1 = ""
    case x2 = "@2x"
    case x3 = "@3x"
}
