import Foundation

/// Operation completed successfully (`ok` schema).
public struct OK: Codable, Equatable, Sendable {
    public let description: String?

    public init(description: String? = nil) {
        self.description = description
    }
}
