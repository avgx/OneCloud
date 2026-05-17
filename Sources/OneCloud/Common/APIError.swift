import Foundation

/// Operation terminated unsuccessfully (`error` schema).
public struct APIError: Codable, Equatable, Sendable {
    public let code: Int?
    public let description: String?
    public let key: String?
    public let message: String?
    public let values: [String: String]?
}
