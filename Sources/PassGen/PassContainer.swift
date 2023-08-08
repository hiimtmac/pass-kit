// PassContainer.swift
// Copyright (c) 2023 hiimtmac inc.

import Foundation
import PassCore

// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/PassKit_PG/index.html#//apple_ref/doc/uid/TP40012195-CH1-SW1

/// Images Fill Their Allotted Space
///
/// The pass layout allots a certain area on the front of the pass for each image. Images are scaled (preserving aspect ratio) to fill this allotted space. Images with a different aspect ratio than their allotted space are cropped after being scaled. The space allotted is as follows:
///
/// - The background image (background.png) is displayed behind the entire front of the pass. The expected dimensions are 180 x 220 points. The image is cropped slightly on all sides and blurred. Depending on the image, you can often provide an image at a smaller size and let it be scaled up, because the blur effect hides details. This lets you reduce the file size without a noticeable difference in the pass.
/// - The footer image (footer.png) is displayed near the barcode. The allotted space is 286 x 15 points.
/// - The icon (icon.png) is displayed when a pass is shown on the lock screen and by apps such as Mail when showing a pass attached to an email. The icon should measure 29 x 29 points.
/// - The logo image (logo.png) is displayed in the top left corner of the pass, next to the logo text. The allotted space is 160 x 50 points; in most cases it should be narrower.
/// - The strip image (strip.png) is displayed behind the primary fields. The allotted space is 375 x 98 points for event tickets, 375 x 144 points for gift cards and coupons, and 375 x 123 in all other cases.
/// - The thumbnail image (thumbnail.png) displayed next to the fields on the front of the pass. The allotted space is 90 x 90 points. The aspect ratio should be in the range of 2:3 to 3:2, otherwise the image is cropped.

// MARK: - Boarding Pass

public struct BoardingPass<Image> {
    public var pass: PKPass
    /// base64 encoded @ 87x87 pixels (29x29pts @3x)
    public var icon: Image
    /// base64 encoded
    public var logo: Image?
    /// base64 encoded
    public var footer: Image?

    public init(
        pass: PKPass,
        icon: Image,
        logo: Image? = nil,
        footer: Image? = nil
    ) {
        self.pass = pass
        self.icon = icon
        self.logo = logo
        self.footer = footer
    }
}

extension BoardingPass: Codable where Image: Codable {}
extension BoardingPass: Equatable where Image: Equatable {}
extension BoardingPass: Hashable where Image: Hashable {}

// MARK: - Coupon

public struct Coupon<Image> {
    public var pass: PKPass
    /// base64 encoded @ 87x87 pixels (29x29pts @3x)
    public var icon: Image
    /// base64 encoded
    public var logo: Image?
    /// base64 encoded
    public var strip: Image?

    public init(
        pass: PKPass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil
    ) {
        self.pass = pass
        self.icon = icon
        self.logo = logo
        self.strip = strip
    }
}

extension Coupon: Codable where Image: Codable {}
extension Coupon: Equatable where Image: Equatable {}
extension Coupon: Hashable where Image: Hashable {}

// MARK: - Event Ticket

public struct EventTicket<Image> {
    public var pass: PKPass
    /// base64 encoded @ 87x87 pixels (29x29pts @3x)
    public var icon: Image
    /// base64 encoded
    public var logo: Image?
    /// base64 encoded
    public var strip: Image?
    /// base64 encoded
    public var thumbnail: Image?
    /// base64 encoded
    public var background: Image?

    public init(
        pass: PKPass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil
    ) {
        self.pass = pass
        self.icon = icon
        self.logo = logo
        self.strip = strip
    }

    public init(
        pass: PKPass,
        icon: Image,
        logo: Image? = nil,
        thumbnail: Image? = nil,
        background: Image? = nil
    ) {
        self.pass = pass
        self.icon = icon
        self.logo = logo
        self.thumbnail = thumbnail
        self.background = background
    }
}

extension EventTicket: Codable where Image: Codable {}
extension EventTicket: Equatable where Image: Equatable {}
extension EventTicket: Hashable where Image: Hashable {}

// MARK: - Generic Pass

public struct GenericPass<Image> {
    public var pass: PKPass
    /// base64 encoded @ 87x87 pixels (29x29pts @3x)
    public var icon: Image
    /// base64 encoded
    public var logo: Image?
    /// base64 encoded
    public var thumbnail: Image?

    public init(
        pass: PKPass,
        icon: Image,
        logo: Image? = nil,
        thumbnail: Image? = nil
    ) {
        self.pass = pass
        self.icon = icon
        self.logo = logo
        self.thumbnail = thumbnail
    }
}

extension GenericPass: Codable where Image: Codable {}
extension GenericPass: Equatable where Image: Equatable {}
extension GenericPass: Hashable where Image: Hashable {}

// MARK: - Store Card

public struct StoreCard<Image> {
    public var pass: PKPass
    /// base64 encoded @ 87x87 pixels (29x29pts @3x)
    public var icon: Image
    /// base64 encoded
    public var logo: Image?
    /// base64 encoded
    public var strip: Image?

    public init(
        pass: PKPass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil
    ) {
        self.pass = pass
        self.icon = icon
        self.logo = logo
        self.strip = strip
    }
}

extension StoreCard: Codable where Image: Codable {}
extension StoreCard: Equatable where Image: Equatable {}
extension StoreCard: Hashable where Image: Hashable {}
