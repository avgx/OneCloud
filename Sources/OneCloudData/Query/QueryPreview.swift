import Foundation
import JSONValue

public struct QueryPreview: Codable, Equatable, Sendable {
    public let text: String?
    public let args: [JSONValue]?
}
