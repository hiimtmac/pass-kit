import Foundation

public enum PassDataDetectorType: String, Codable {
    case phoneNumber = "PKDataDetectorTypePhoneNumber"
    case link = "PKDataDetectorTypeLink"
    case address = "PKDataDetectorTypeAddress"
    case calendarEvent = "PKDataDetectorTypeCalendarEvent"
}
