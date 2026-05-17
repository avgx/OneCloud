import Foundation

public struct DomainManagedField: Codable, Equatable, Sendable, Identifiable {
    public let id: Int64
    public let name: String?
    public let description: String?
    public let type: String?
    public let required: Bool?
    public let value: String?
    public let enumValues: [String]?
}
