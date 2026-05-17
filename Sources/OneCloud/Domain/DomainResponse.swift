import Foundation

/// Paginated list of domains (`presentDomainList` schema).
public struct DomainResponse: Codable, Equatable, Sendable {
    public let domains: [DomainResponseItem]
    public let totalCount: Int64
    public let countInPage: Int64
}
