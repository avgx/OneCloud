import Foundation

public struct InnerError: Codable, Equatable, Sendable {
    public let description: String?
    public let error: String?
    public let httpStatus: Int?
}
