import Foundation

public struct LicenseKeyWithCameraStats: Codable, Equatable, Sendable, Identifiable {
    public let id: Int64
    public let name: String
    public let saleSystemId: String
    public let expireTime: String
    public let domainsCount: Int
    public let notificationExists: Bool
    public let cameraStats: CameraStats?
}
