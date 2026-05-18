import Foundation
import JSONValue

public struct QueryBatchResponse: Codable, Equatable, Sendable {
    public let total: Int?
    public let status: Int?
    public let result: [[QueryRow]]
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

        if let result = try? container.decode([[QueryRow]].self, forKey: .result) {
            self.result = result
        } else if let values = try? container.decode([JSONValue].self, forKey: .result) {
            self.result = values.map { batchItem in
                batchItem.arrayValue?.compactMap(\.objectValue) ?? []
            }
        } else {
            self.result = []
        }
    }
}
