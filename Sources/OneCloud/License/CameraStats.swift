import Foundation

public struct CameraStats: Codable, Equatable, Sendable {
    public let total: Int64?
    public let used: Int64?
}
