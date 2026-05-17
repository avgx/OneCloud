import Foundation

/// Current user with permissions (`userWithPermissions` schema).
public struct UserWithPermissions: Decodable, Equatable, Sendable {
    public let user: User?
    public let permissionStorage: UserPermissionStorage
    public let domainManagedFields: [DomainManagedField]?
    public let maxLogoutTTLLimit: Int64?
    public let twoFactorAuthType: String?
    public let userNotifySettings: NotifySettings?

    private enum CodingKeys: String, CodingKey {
        case user
        case permission
        case domainManagedFields
        case maxLogoutTTLLimit
        case twoFactorAuthType
        case userNotifySettings
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        user = try container.decodeIfPresent(User.self, forKey: .user)
        domainManagedFields = try container.decodeIfPresent([DomainManagedField].self, forKey: .domainManagedFields)
        maxLogoutTTLLimit = try container.decodeIfPresent(Int64.self, forKey: .maxLogoutTTLLimit)
        twoFactorAuthType = try container.decodeIfPresent(String.self, forKey: .twoFactorAuthType)
        userNotifySettings = try container.decodeIfPresent(NotifySettings.self, forKey: .userNotifySettings)

        let permissionJWT = try container.decode(String.self, forKey: .permission)
        permissionStorage = try JWTPermissionDecoder.decodePermissionStorage(from: permissionJWT)
    }

    public func hasPermissions() -> [UserGlobalPermission] {
        permissionStorage.compactMap { key, value in
            value ? UserGlobalPermission(rawValue: key) : nil
        }
    }

    public func hasPermission(_ permission: UserGlobalPermission) -> Bool {
        permissionStorage[permission.rawValue] ?? false
    }
}
