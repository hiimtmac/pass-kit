// Barcode.swift
// Copyright (c) 2025 hiimtmac inc.

// https://developer.apple.com/documentation/walletpasses/pass/barcodes
extension Pass {
    /// Information about a pass’s barcode
    public struct Barcode: Codable, Equatable, Hashable, Sendable {
        /// The text to display near the barcode. For example, a human-readable version of the barcode data in case the barcode doesn’t scan.
        ///
        /// The alternative text isn’t displayed for watchOS.
        public var altText: String?

        /// The format of the barcode.
        ///
        /// The barcode format PKBarcodeFormatCode128 isn’t supported for watchOS.
        public var format: BarcodeFormat

        /// The message or payload to display as a barcode.
        public var message: String

        /// The IANA character set name of the text encoding to use to convert message from a string representation to a data representation that the system renders as a barcode, such as “iso-8859-1”.
        public var messageEncoding: CharacterEncoding

        /// Information about a pass’s barcode
        /// - Parameters:
        ///   - altText: The text to display near the barcode. For example, a human-readable version of the barcode data in case the barcode doesn’t scan.
        ///   - format: The format of the barcode.
        ///   - message: The message or payload to display as a barcode.
        ///   - messageEncoding: The IANA character set name of the text encoding to use to convert message from a string representation to a data representation that the system renders as a barcode, such as “iso-8859-1”.
        public init(
            altText: String? = nil,
            format: BarcodeFormat,
            message: String,
            messageEncoding: CharacterEncoding
        ) {
            self.altText = altText
            self.format = format
            self.message = message
            self.messageEncoding = messageEncoding
        }
    }
}

extension Pass.Barcode {
    public enum BarcodeFormat: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case qr = "PKBarcodeFormatQR"
        case pdf = "PKBarcodeFormatPDF417"
        case aztec = "PKBarcodeFormatAztec"
        case code128 = "PKBarcodeFormatCode128"
    }

    /// See: https://docs.lansa.com/14/en/lansa093/content/lansa/intb7_0510.htm
    public enum CharacterEncoding: String, Codable, Equatable, Hashable, CaseIterable, Sendable {
        case utf8 = "utf-8"

        case utf16be = "utf-16be"
        case utf16le = "utf-16le"

        case ascii

        case iso88591 = "iso-8859-1"
        case iso88592 = "iso-8859-2"
        case iso88593 = "iso-8859-3"
        case iso88594 = "iso-8859-4"
        case iso88595 = "iso-8859-5"
        case iso88596 = "iso-8859-6"
        case iso88597 = "iso-8859-7"
        case iso88598 = "iso-8859-8"
        case iso88599 = "iso-8859-9"
        case iso885913 = "iso-8859-13"
        case iso885915 = "iso-8859-15"

        case windows1250 = "windows-1250"
        case windows1251 = "windows-1251"
        case windows1252 = "windows-1252"
        case windows1253 = "windows-1253"
        case windows1254 = "windows-1254"
        case windows1255 = "windows-1255"
        case windows1256 = "windows-1256"
        case windows1257 = "windows-1257"
        case windows874 = "windows-874"
        case windows932 = "windows-932"
        case windows936 = "windows-936"
        case windows949 = "windows-949"
        case windows950 = "windows-950"

        case ebcdiccpus = "ebcdic-cp-us"
        case ebcdiccpdk = "ebcdic-cp-dk"
        case ebcdiccpfi = "ebcdic-cp-fi"
        case ebcdiccpit = "ebcdic-cp-it"
        case ebcdiccpes = "ebcdic-cp-es"
        case ebcdiccpgb = "ebcdic-cp-gb"
        case ebcdicjpkana = "ebcdic-jp-kana"
        case ebcdiccpfr = "ebcdic-cp-fr"
        case ebcdiccphe = "ebcdic-cp-he"
        case ebcdiccpch = "ebcdic-cp-ch"
        case ebcdiccpyu = "ebcdic-cp-yu"
        case ebcdiccpis = "ebcdic-cp-is"
        case ebcdiccpar2 = "ebcdic-cp-ar2"
        case ebcdiccpar1 = "ebcdic-cp-ar1"
        case ebcdicus37euro = "ebcdic-us-37+euro"
        case ebcdicde273euro = "ebcdic-de-273+euro"
        case ebcdicdk227euro = "ebcdic-dk-227+euro"
        case ebcdicfi278euro = "ebcdic-fi-278+euro"
        case ebcdicit280euro = "ebcdic-it-280+euro"
        case ebcdices284euro = "ebcdic-es-284+euro"
        case ebcdicgb285euro = "ebcdic-gb-285+euro"
        case ebcdicfr297euro = "ebcdic-fr-297+euro"
        case ebcdicinternational500euro = "ebcdic-international-500+euro"
        case ebcdicis871euro = "ebcdic-is-871+euro"

        case eucjis = "euc-jis"
        case eucjp = "euc-jp"

        case iso2022jp = "iso2022-jp"

        case shiftjis = "Shift_JIS"

        case big5

        case gb2312

        case koi8r = "koi8-r"

        case euckr = "euc-kr"

        case ibm273 = "ibm-273"
        case ibm437 = "ibm-437"
        case ibm775 = "ibm-775"
        case ibm850 = "ibm-850"
        case ibm852 = "ibm-852"
        case ibm855 = "ibm-855"
        case ibm857 = "ibm-857"
        case ibm860 = "ibm-860"
        case ibm861 = "ibm-861"
        case ibm862 = "ibm-862"
        case ibm863 = "ibm-863"
        case ibm864 = "ibm-864"
        case ibm865 = "ibm-865"
        case ibm866 = "ibm-866"
        case ibm868 = "ibm-868"
        case ibm869 = "ibm-869"
        case ibm1026 = "ibm-1026"
        case ibm1047 = "ibm-1047"

        public init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self).lowercased()
            guard let encoding = Self(rawValue: value) else {
                throw DecodingError.dataCorrupted(.init(
                    codingPath: decoder.codingPath,
                    debugDescription: "Cannot initialize \(Self.self) from invalid String value \(value)"
                ))
            }

            self = encoding
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue.lowercased())
        }
    }
}
