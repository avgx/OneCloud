import Foundation
import RequestResponse

/// User API
public enum UsersApi {
    /// GET /users/{userId} — `CurrentUser`
    public static func get(userId: Int64) -> Request<UserWithPermissions> {
        Request(path: "users/\(userId)", method: .get)
    }
}
