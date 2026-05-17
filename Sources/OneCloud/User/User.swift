import Foundation

public struct User: Codable, Equatable, Sendable, Identifiable {
    public var id: Int64 { userId ?? 0 }

    public let userId: Int64?
    public let login: String?
    public let name: String?
    public let email: String?
    public let locale: String?
    public let timezone: String?
    public let createdTime: String?
    public let avatarDownloadLink: String?
    public let enabled2FA: Bool?
    public let activatedTOTP: Bool?
    public let inactiveLogoutTTLMin: Int64?
    public let ldapSourceId: Int64?
    public let sessionCount: Int64?
    public let socialNetwork: Bool?
    public let phoneNumberRegistered: Bool?
    public let userSpecifiedPassword: Bool?
}
