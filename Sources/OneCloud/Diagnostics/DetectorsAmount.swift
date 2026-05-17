import Foundation

public struct DetectorsAmount: Codable, Equatable, Sendable {
    public let total: Int64?
    public let types: [DetectorAmountType]?
}

public struct DetectorAmountType: Codable, Equatable, Sendable {
    public let detectorType: String?
    public let amount: Int64?
}
