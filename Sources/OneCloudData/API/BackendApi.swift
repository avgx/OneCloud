import Foundation
import RequestResponse

/// Axxon Data backend (`/api/v1/ad-backend`)
/// use a separate `RequestBuilder` base URL.
public enum BackendApi {
    /// GET /users/my/dashboards
    public static func dashboards() -> Request<[Dashboard]> {
        Request(path: "users/my/dashboards", method: .get)
    }

    /// GET /user/share/token
    public static func shareToken() -> Request<ShareToken> {
        Request(path: "user/share/token", method: .get)
    }
}
