import Foundation

public struct OrderBy: Codable, Equatable, Sendable {
    public var field: String
    public var desc: Bool?
    public var dayOfWeek: Bool?

    public init(field: String, desc: Bool? = nil, dayOfWeek: Bool? = nil) {
        self.field = field
        self.desc = desc
        self.dayOfWeek = dayOfWeek
    }

    public init(_ field: EventFieldName, desc: Bool? = nil, dayOfWeek: Bool? = nil) {
        self.init(field: field.rawValue, desc: desc, dayOfWeek: dayOfWeek)
    }

    public static func asc(_ field: EventFieldName) -> OrderBy {
        OrderBy(field, desc: false)
    }

    public static func desc(_ field: EventFieldName) -> OrderBy {
        OrderBy(field, desc: true)
    }
}
