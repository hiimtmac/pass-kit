// PassContainer.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation
import PassCore

// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/index.html#//apple_ref/doc/uid/TP40012195-CH1-SW1

/// Images Fill Their Allotted Space
///
/// The pass layout allots a certain area on the front of the pass for each image. Images are scaled (preserving aspect ratio) to fill this allotted space. Images with a different aspect ratio than their allotted space are cropped after being scaled
public struct PassContainer<Image> {
    public var pass: Pass
    /// The icon (icon.png) is displayed when a pass is shown on the lock screen and by apps such as Mail when showing a pass attached to an email. The icon should measure 29 x 29 points.
    public var icon: Image
    /// The logo image (logo.png) is displayed in the top left corner of the pass, next to the logo text. The allotted space is 160 x 50 points; in most cases it should be narrower.
    public var logo: Image?
    /// The strip image (strip.png) is displayed behind the primary fields. The allotted space is 375 x 98 points for event tickets, 375 x 144 points for gift cards and coupons, and 375 x 123 in all other cases.
    public var strip: Image?
    /// The footer image (footer.png) is displayed near the barcode. The allotted space is 286 x 15 points.
    public var footer: Image?
    /// The thumbnail image (thumbnail.png) displayed next to the fields on the front of the pass. The allotted space is 90 x 90 points. The aspect ratio should be in the range of 2:3 to 3:2, otherwise the image is cropped.
    public var thumbnail: Image?
    /// The background image (background.png) is displayed behind the entire front of the pass. The expected dimensions are 180 x 220 points. The image is cropped slightly on all sides and blurred. Depending on the image, you can often provide an image at a smaller size and let it be scaled up, because the blur effect hides details. This lets you reduce the file size without a noticeable difference in the pass.
    public var background: Image?

    public init(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil,
        footer: Image? = nil,
        thumbnail: Image? = nil,
        background: Image? = nil
    ) {
        self.pass = pass
        self.icon = icon
        self.logo = logo
        self.strip = strip
        self.footer = footer
        self.thumbnail = thumbnail
        self.background = background
    }

    public static func boardingPass(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        footer: Image? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            strip: nil,
            footer: footer,
            thumbnail: nil,
            background: nil
        )
    }

    public static func coupon(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            strip: strip,
            footer: nil,
            thumbnail: nil,
            background: nil
        )
    }

    public static func eventTicket(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            strip: strip,
            footer: nil,
            thumbnail: nil,
            background: nil
        )
    }

    public static func eventTicket(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        thumbnail: Image? = nil,
        background: Image? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            strip: nil,
            footer: nil,
            thumbnail: thumbnail,
            background: background
        )
    }

    public static func generic(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        thumbnail: Image? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            strip: nil,
            footer: nil,
            thumbnail: thumbnail,
            background: nil
        )
    }

    public static func storeCard(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            strip: strip,
            footer: nil,
            thumbnail: nil,
            background: nil
        )
    }
}

extension PassContainer: Codable where Image: Codable {}
extension PassContainer: Equatable where Image: Equatable {}
extension PassContainer: Hashable where Image: Hashable {}
extension PassContainer: Sendable where Image: Sendable {}
