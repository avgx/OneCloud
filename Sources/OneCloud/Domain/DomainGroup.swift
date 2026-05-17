import Foundation

public struct DomainGroup: Codable, Equatable, Sendable, Identifiable {
    public let id: Int64
    public let name: String?
    public let path: String?
    public let domainsCount: Int64?
    public let onlineDomainsCount: Int64?
    public let offlineDomainsCount: Int64?
}
