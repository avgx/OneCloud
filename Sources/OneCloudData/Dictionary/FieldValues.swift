import Foundation

public struct FieldValues: Codable, Equatable, Sendable {
    public let total: Int
    public let status: Int
    public let result: [FieldValue]
}

public struct FieldValue: Codable, Equatable, Sendable {
    public let key: String
    public let value: String?
    public let translation: String?

    enum CodingKeys: String, CodingKey {
        case key
        case value
        case translation
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let key = try? container.decode(String.self, forKey: .key) {
            self.key = key
        } else if let key = try? container.decode(Int.self, forKey: .key) {
            self.key = String(key)
        } else if let key = try? container.decode(Double.self, forKey: .key) {
            self.key = String(key)
        } else {
            self.key = ""
        }

        self.value = try container.decodeIfPresent(String.self, forKey: .value)
        self.translation = try container.decodeIfPresent(String.self, forKey: .translation)
    }
}
