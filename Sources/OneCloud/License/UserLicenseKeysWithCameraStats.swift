import Foundation

public struct UserLicenseKeysWithCameraStats: Codable, Equatable, Sendable {
    public let personalKeys: [LicenseKeyWithCameraStats]?
    public let sharedKeys: [LicenseKeyWithCameraStats]?
}
