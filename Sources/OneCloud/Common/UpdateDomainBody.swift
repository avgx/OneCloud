import Foundation

/// Body for `PATCH /domains/{domainId}`.
public struct UpdateDomainBody: Codable, Equatable, Sendable {
    public let newName: String?

    public init(newName: String? = nil) {
        self.newName = newName
    }
}
