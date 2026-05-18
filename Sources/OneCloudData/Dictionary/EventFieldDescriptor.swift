import Foundation

public struct EventFieldDescriptor: Codable, Equatable, Sendable {
    public let key: String?
    public let value: String?
    public let type: String
    public let resultType: String?
    public let childs: [String]?
    public let fields: [String]?
    public let tables: [String]?

    enum CodingKeys: String, CodingKey {
        case key
        case value
        case type
        case resultType = "result_type"
        case childs
        case fields
        case tables
    }
}
