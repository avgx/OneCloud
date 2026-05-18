import Foundation

public struct TimePeriod: Codable, Equatable, Sendable {
    public let type: String
    public let translation: String
    public let main: Bool
    public let compare: Bool
    public let tag: TimePeriodTag
    public let from: String?
    public let to: String?
}

public struct TimePeriodTag: Codable, Equatable, Sendable {
    public let type: String
    public let translation: String
}
