// Localization.swift
// Copyright (c) 2025 hiimtmac inc.

import Foundation

public struct Localization<Image> {
    public var code: String
    public var keys: [LocalizedKey]?

    public var logoImage: Image?
    /// The strip image (strip.png) is displayed behind the primary fields. The allotted space is 375 x 98 points for event tickets, 375 x 144 points for gift cards and coupons, and 375 x 123 in all other cases.
    public var stripImage: Image?
    /// The footer image (footer.png) is displayed near the barcode. The allotted space is 286 x 15 points.
    public var footerImage: Image?
    /// The thumbnail image (thumbnail.png) displayed next to the fields on the front of the pass. The allotted space is 90 x 90 points. The aspect ratio should be in the range of 2:3 to 3:2, otherwise the image is cropped.
    public var thumbnailImage: Image?
    /// The background image (background.png) is displayed behind the entire front of the pass. The expected dimensions are 180 x 220 points. The image is cropped slightly on all sides and blurred. Depending on the image, you can often provide an image at a smaller size and let it be scaled up, because the blur effect hides details. This lets you reduce the file size without a noticeable difference in the pass.
    public var backgroundImage: Image?

    public init(
        code: String,
        keys: [LocalizedKey]? = nil,
        logo: Image? = nil,
        strip: Image? = nil,
        footer: Image? = nil,
        thumbnail: Image? = nil,
        background: Image? = nil
    ) {
        self.code = code
        self.keys = keys
        self.logoImage = logo
        self.stripImage = strip
        self.footerImage = footer
        self.thumbnailImage = thumbnail
        self.backgroundImage = background
    }

    public static func boardingPass(
        code: String,
        keys: [LocalizedKey]? = nil,
        logo: Image? = nil,
        footer: Image? = nil
    ) -> Self {
        .init(
            code: code,
            keys: keys,
            logo: logo,
            footer: footer
        )
    }

    public static func coupon(
        code: String,
        keys: [LocalizedKey]? = nil,
        logo: Image? = nil,
        strip: Image? = nil
    ) -> Self {
        .init(
            code: code,
            keys: keys,
            logo: logo,
            strip: strip
        )
    }

    public static func eventTicket(
        code: String,
        keys: [LocalizedKey]? = nil,
        logo: Image? = nil,
        strip: Image? = nil
    ) -> Self {
        .init(
            code: code,
            keys: keys,
            logo: logo,
            strip: strip
        )
    }

    public static func eventTicket(
        code: String,
        keys: [LocalizedKey]? = nil,
        logo: Image? = nil,
        thumbnail: Image? = nil,
        background: Image? = nil
    ) -> Self {
        .init(
            code: code,
            keys: keys,
            logo: logo,
            thumbnail: thumbnail,
            background: background
        )
    }

    public static func generic(
        code: String,
        keys: [LocalizedKey]? = nil,
        logo: Image? = nil,
        thumbnail: Image? = nil
    ) -> Self {
        .init(
            code: code,
            keys: keys,
            logo: logo,
            thumbnail: thumbnail
        )
    }

    public static func storeCard(
        code: String,
        keys: [LocalizedKey]? = nil,
        logo: Image? = nil,
        strip: Image? = nil
    ) -> Self {
        .init(
            code: code,
            keys: keys,
            logo: logo,
            strip: strip
        )
    }
}

extension Localization: Codable where Image: Codable {}
extension Localization: Equatable where Image: Equatable {}
extension Localization: Hashable where Image: Hashable {}
extension Localization: Sendable where Image: Sendable {}

public struct LocalizedKey {
    public var key: String
    public var value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

extension LocalizedKey: Codable {}
extension LocalizedKey: Equatable {}
extension LocalizedKey: Hashable {}
extension LocalizedKey: Sendable {}
