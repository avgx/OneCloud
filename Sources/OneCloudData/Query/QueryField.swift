import Foundation
import JSONValue

public struct QueryField: Codable, Equatable, Sendable {
    public var field: String?
    public var alias: String?
    public var aggregationFunc: String?
    public var prefix: String?
    public var builtinFunc: String?
    public var expression: JSONValue?
    public var timeInterval: String?

    public init(
        field: String? = nil,
        alias: String? = nil,
        aggregationFunc: String? = nil,
        prefix: String? = nil,
        builtinFunc: String? = nil,
        expression: JSONValue? = nil,
        timeInterval: String? = nil
    ) {
        self.field = field
        self.alias = alias
        self.aggregationFunc = aggregationFunc
        self.prefix = prefix
        self.builtinFunc = builtinFunc
        self.expression = expression
        self.timeInterval = timeInterval
    }

    public init(_ field: EventFieldName, alias: String? = nil, aggregation: Aggregation? = nil) {
        self.init(field: field.rawValue, alias: alias, aggregationFunc: aggregation?.rawValue)
    }

    public static func count(_ field: EventFieldName = .eventVersion, alias: String = Aggregation.count.alias) -> QueryField {
        QueryField(field, alias: alias, aggregation: .count)
    }
}
