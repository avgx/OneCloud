import Foundation

public struct DomainRegions: Codable, Equatable, Sendable {
    public let managedDomainsRegions: [String]?
    public let remoteDomainsRegions: [String]?
}
