import Foundation

public struct DomainObjectsAmount: Codable, Equatable, Sendable, Identifiable {
    public var id: Int64 { domainId ?? 0 }

    public let domainId: Int64?
    public let nodes: [NodeAmount]?
}
