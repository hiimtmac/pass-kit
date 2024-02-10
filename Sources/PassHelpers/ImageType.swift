// ImageType.swift
// Copyright (c) 2024 hiimtmac inc.

import Foundation

public enum PassImage {
    case icon
    case logo
    case thumbnail
    case strip(StripType)
    case background
    case footer

    public enum StripType {
        case coupon
        case eventTicket
        case storeCard

        public var size: CGSize {
            switch self {
            case .coupon: CGSize(width: 375, height: 144)
            case .eventTicket: CGSize(width: 375, height: 98)
            case .storeCard: CGSize(width: 375, height: 123)
            }
        }

        public var ratio: CGFloat {
            size.width / size.height
        }
    }

    public var size: CGSize {
        switch self {
        case .icon: CGSize(width: 29, height: 29)
        case .logo: CGSize(width: 160, height: 50)
        case .thumbnail: CGSize(width: 90, height: 90)
        case let .strip(strip): strip.size
        case .background: CGSize(width: 180, height: 220)
        case .footer: CGSize(width: 286, height: 15)
        }
    }

    public var ratio: CGFloat {
        size.width / size.height
    }
}
