import Foundation
import JSONValue

public struct Clause: Codable, Equatable, Sendable {
    public var field: String
    public var op: String
    public var value: JSONValue
    public var id: String?
    public var type: String?

    public init(field: String, op: String, value: JSONValue, id: String? = nil, type: String? = nil) {
        self.field = field
        self.op = op
        self.value = value
        self.id = id
        self.type = type
    }

    public static func eq(_ field: EventFieldName, _ value: String) -> Clause {
        Clause(field: field.rawValue, op: "eq", value: .string(value))
    }

    public static func eq(_ field: EventFieldName, _ value: Int) -> Clause {
        Clause(field: field.rawValue, op: "eq", value: JSONValue(integerLiteral: value))
    }

    public static func `in`(_ field: EventFieldName, _ values: [String]) -> Clause {
        Clause(field: field.rawValue, op: "in", value: .array(values.map(JSONValue.string)))
    }

    public static func `in`(_ field: EventFieldName, _ values: [Int]) -> Clause {
        Clause(field: field.rawValue, op: "in", value: .array(values.map(JSONValue.integer(_:))))
    }
}
