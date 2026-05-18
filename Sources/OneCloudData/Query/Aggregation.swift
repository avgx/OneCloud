import Foundation

public enum Aggregation: String, Codable, Sendable, CaseIterable {
    case sum
    case average = "avg"
    case maximum = "max"
    case minimum = "min"
    case count
    case lastValue = "last_value"

    public var alias: String {
        switch self {
        case .sum:
            return "@sum"
        case .average:
            return "@avg"
        case .maximum:
            return "@max"
        case .minimum:
            return "@min"
        case .count:
            return "@count"
        case .lastValue:
            return "@last_value"
        }
    }
}
