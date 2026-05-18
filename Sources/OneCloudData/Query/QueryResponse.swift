import Foundation
import JSONValue

public typealias QueryRow = [String: JSONValue]

public struct QueryResponse: Codable, Equatable, Sendable {
    public let total: Int?
    public let status: Int?
    public let result: [QueryRow]
    public let compare: JSONValue?
    public let delta: JSONValue?

    enum CodingKeys: String, CodingKey {
        case total
        case status
        case result
        case compare
        case delta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.status = try container.decodeIfPresent(Int.self, forKey: .status)
        self.compare = try container.decodeIfPresent(JSONValue.self, forKey: .compare)
        self.delta = try container.decodeIfPresent(JSONValue.self, forKey: .delta)

        if let rows = try? container.decode([QueryRow].self, forKey: .result) {
            self.result = rows
        } else if let values = try? container.decode([JSONValue].self, forKey: .result) {
            self.result = values.compactMap(\.objectValue)
        } else {
            self.result = []
        }
    }
}

public extension QueryRow {
    func value(forAlias alias: String) -> JSONValue? {
        if let value = self[alias] {
            return value
        }
        if alias.hasPrefix("@") {
            return self[String(alias.dropFirst())]
        }
        return self["@\(alias)"]
    }

    func intValue(forAlias alias: String) -> Int? {
        value(forAlias: alias)?.intValue
    }

    func doubleValue(forAlias alias: String) -> Double? {
        value(forAlias: alias)?.doubleValue
    }
}

public extension QueryResponse {
    var allKeys: [String] {
        Array(Set(result.flatMap(\.keys))).sorted()
    }

    var orderedKeys: [String] {
        let countKeys = allKeys.filter { $0.lowercased() == "@count" || $0.lowercased() == "count" }
        let otherKeys = allKeys.filter { $0.lowercased() != "@count" && $0.lowercased() != "count" }
        return otherKeys + countKeys
    }

    var countValue: Int {
        result.first?.intValue(forAlias: Aggregation.count.alias) ?? 0
    }

    func doubleValue(forAlias alias: String) -> Double? {
        result.first?.doubleValue(forAlias: alias)
    }

    func dictionaryFields(from fields: [EventField]) -> [EventField] {
        let keys = Set(allKeys)
        return fields.filter { field in
            keys.contains(field.name) && field.descriptor.dictionaryType != nil
        }
    }

    func dictionaryRequests(from fields: [EventField]) -> [FieldDictionaryRequest] {
        dictionaryFields(from: fields).compactMap(\.dictionaryRequest)
    }
}
