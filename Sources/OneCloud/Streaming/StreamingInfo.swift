import Foundation

public struct StreamingInfo: Codable, Equatable, Sendable, Identifiable {
    public let key: UUID
    public let name: String?
    public let rtmpLink: String?
    public let rtspLink: String?
    public let rtmpsLink: String?
    public let rtspsLink: String?

    public var id: String { key.uuidString }
}

public struct StreamingError: Codable, Equatable, Sendable {
    public let key: String
    public let description: String
}
