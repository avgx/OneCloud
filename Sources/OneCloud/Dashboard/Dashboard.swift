import Foundation

public struct Dashboard: Codable, Equatable, Sendable, Identifiable {
    public let id: String
    public let title: String
    public let description: String
    public let tags: String
}

public struct ShareToken: Codable, Equatable, Sendable {
    public let shareToken: String
}
