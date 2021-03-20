import Foundation

public struct PassStructure: Codable {
    /// Additional fields to be displayed on the front of the pass.
    public var auxiliaryFields: [PassField]?
    /// Fields to be on the back of the pass.
    public var backFields: [PassField]?
    /// Fields to be displayed in the header on the front of the pass.
    /// Use header fields sparingly; unlike all other fields, they remain visible when a stack of passes are displayed.
    public var headerFields: [PassField]?
    /// Fields to be displayed prominently on the front of the pass.
    public var primaryFields: [PassField]?
    /// Fields to be displayed on the front of the pass.
    public var secondaryFields: [PassField]?
    /// Required for boarding passes; otherwise not allowed. Type of transit.
    public var transitType: PassTransitType?
    
    public init(
        auxiliaryFields: [PassField]? = nil,
        backFields: [PassField]? = nil,
        headerFields: [PassField]? = nil,
        primaryFields: [PassField]? = nil,
        secondaryFields: [PassField]? = nil,
        transitType: PassTransitType? = nil
    ) {
        self.auxiliaryFields = auxiliaryFields
        self.backFields = backFields
        self.headerFields = headerFields
        self.primaryFields = primaryFields
        self.secondaryFields = secondaryFields
        self.transitType = transitType
    }
}
