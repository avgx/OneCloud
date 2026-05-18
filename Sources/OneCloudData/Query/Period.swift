import Foundation

public struct Period: Codable, Equatable, Sendable {
    public var type: String
    public var compare: String?
    public var from: String?
    public var to: String?
    public var timeZone: String?

    public init(
        type: String,
        compare: String? = nil,
        from: String? = nil,
        to: String? = nil,
        timeZone: String? = nil
    ) {
        self.type = type
        self.compare = compare
        self.from = from
        self.to = to
        self.timeZone = timeZone
    }

    public init(
        _ kind: TimePeriodKind,
        compare: TimePeriodKind? = nil,
        from: String? = nil,
        to: String? = nil,
        timeZone: String? = nil
    ) {
        self.init(
            type: kind.rawValue,
            compare: compare?.rawValue,
            from: from,
            to: to,
            timeZone: timeZone
        )
    }

    public static func userDefined(from: String, to: String, timeZone: String? = nil) -> Period {
        Period(.userDefined, from: from, to: to, timeZone: timeZone)
    }
}
