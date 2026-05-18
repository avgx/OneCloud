import Foundation

public struct EventField: Codable, Equatable, Sendable {
    public let name: String
    public let translation: String
    public let descriptor: EventFieldDescriptor
}
