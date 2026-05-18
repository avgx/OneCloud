import Foundation
import JSONValue

public struct QueryHaving: Codable, Equatable, Sendable {
    public var field: QueryField
    public var op: String
    public var value: JSONValue

    public init(field: QueryField, op: String, value: JSONValue) {
        self.field = field
        self.op = op
        self.value = value
    }
}
