import Foundation

/// Domains and groups tree (`domainsListWithGroups` schema).
public struct DomainsListWithGroups: Codable, Equatable, Sendable {
    public let domains: [DomainResponseItem]
    public let domainGroups: [DomainGroup]
}
