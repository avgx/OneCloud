import Foundation

public enum EventFieldResultType: String, Codable, Sendable, CaseIterable {
    case dictionary
    case set
    case string
    case integer
    case number
    case double
    case date
    case datetime
    case composite
    case image
    case json
    case boolean
}
