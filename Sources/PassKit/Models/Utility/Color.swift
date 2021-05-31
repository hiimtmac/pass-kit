import Foundation

public struct Color: Codable {
    let r: Int
    let g: Int
    let b: Int
    
    public var string: String {
        "rgb(\(r),\(g),\(b))"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
    
    public init(r: Int, g: Int, b: Int) {
        self.r = r
        self.g = g
        self.b = b
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        let trimmed = String(string.dropFirst(4).dropLast())
        let components = trimmed.components(separatedBy: ",")
        self.r = Int(components[0])!
        self.g = Int(components[1])!
        self.b = Int(components[2])!
    }
}
