import Foundation

public struct Amount: Codable, Equatable, Sendable {
    public let cameras: Int64?
    public let archives: Int64?
    public let detectors: DetectorsAmount?
}
