import Foundation

/// Domain with managed fields and user permissions (`presentDomain` schema).
public struct DomainResponseItem: Codable, Equatable, Sendable {
    public let domain: Domain
    public let domainManagedFields: [DomainManagedField]?
    public let domainNodeId: Int64?
    public let isSynced: Bool?
    public let permission: Permission?
}
