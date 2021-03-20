import Foundation

public enum PassBarcodeFormat: String, Codable {
    case qr = "PKBarcodeFormatQR"
    case pdf = "PKBarcodeFormatPDF417"
    case aztec = "PKBarcodeFormatAztec"
    case code128 = "PKBarcodeFormatCode128"
}
