// ImageType.swift
// Copyright (c) 2023 hiimtmac inc.

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
            case .coupon: return CGSize(width: 375, height: 144)
            case .eventTicket: return CGSize(width: 375, height: 98)
            case .storeCard: return CGSize(width: 375, height: 123)
            }
        }
    }

    public var size: CGSize {
        switch self {
        case .icon: return CGSize(width: 29, height: 29)
        case .logo: return CGSize(width: 160, height: 50)
        case .thumbnail: return CGSize(width: 90, height: 90)
        case let .strip(strip): return strip.size
        case .background: return CGSize(width: 180, height: 220)
        case .footer: return CGSize(width: 286, height: 15)
        }
    }
}
