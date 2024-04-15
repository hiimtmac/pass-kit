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
    public var iconImage: Image
    /// The logo image (logo.png) is displayed in the top left corner of the pass, next to the logo text. The allotted space is 160 x 50 points; in most cases it should be narrower.
    public var logoImage: Image?
    /// The strip image (strip.png) is displayed behind the primary fields. The allotted space is 375 x 98 points for event tickets, 375 x 144 points for gift cards and coupons, and 375 x 123 in all other cases.
    public var stripImage: Image?
    /// The footer image (footer.png) is displayed near the barcode. The allotted space is 286 x 15 points.
    public var footerImage: Image?
    /// The thumbnail image (thumbnail.png) displayed next to the fields on the front of the pass. The allotted space is 90 x 90 points. The aspect ratio should be in the range of 2:3 to 3:2, otherwise the image is cropped.
    public var thumbnailImage: Image?
    /// The background image (background.png) is displayed behind the entire front of the pass. The expected dimensions are 180 x 220 points. The image is cropped slightly on all sides and blurred. Depending on the image, you can often provide an image at a smaller size and let it be scaled up, because the blur effect hides details. This lets you reduce the file size without a noticeable difference in the pass.
    public var backgroundImage: Image?

    public var personalization: Personalization?
    public var personalizationImage: Image?

    public var localizations: [Localization<Image>]?

    public init(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil,
        footer: Image? = nil,
        thumbnail: Image? = nil,
        background: Image? = nil,
        personalization: Personalization? = nil,
        personalizationLogo: Image? = nil,
        localizations: [Localization<Image>]? = nil
    ) {
        self.pass = pass
        self.iconImage = icon
        self.logoImage = logo
        self.stripImage = strip
        self.footerImage = footer
        self.thumbnailImage = thumbnail
        self.backgroundImage = background
        self.personalization = personalization
        self.personalizationImage = personalizationLogo
        self.localizations = localizations
    }

    public static func boardingPass(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        footer: Image? = nil,
        localizations: [Localization<Image>]? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            footer: footer,
            localizations: localizations
        )
    }

    public static func coupon(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil,
        localizations: [Localization<Image>]? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            strip: strip,
            localizations: localizations
        )
    }

    public static func eventTicket(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil,
        localizations: [Localization<Image>]? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            strip: strip,
            localizations: localizations
        )
    }

    public static func eventTicket(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        thumbnail: Image? = nil,
        background: Image? = nil,
        localizations: [Localization<Image>]? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            thumbnail: thumbnail,
            background: background,
            localizations: localizations
        )
    }

    public static func generic(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        thumbnail: Image? = nil,
        localizations: [Localization<Image>]? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            thumbnail: thumbnail,
            localizations: localizations
        )
    }

    public static func storeCard(
        pass: Pass,
        icon: Image,
        logo: Image? = nil,
        strip: Image? = nil,
        localizations: [Localization<Image>]? = nil,
        personalization: Personalization? = nil,
        personalizationLogo: Image? = nil
    ) -> Self {
        .init(
            pass: pass,
            icon: icon,
            logo: logo,
            strip: strip,
            personalization: personalization,
            personalizationLogo: personalizationLogo,
            localizations: localizations
        )
    }
}

extension PassContainer: Codable where Image: Codable {}
extension PassContainer: Equatable where Image: Equatable {}
extension PassContainer: Hashable where Image: Hashable {}
extension PassContainer: Sendable where Image: Sendable {}
