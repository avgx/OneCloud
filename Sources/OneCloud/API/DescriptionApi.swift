import Foundation
import RequestResponse

/// Description API
public enum DescriptionApi {
    /// GET /about
    public static func about() -> Request<OK> {
        Request(path: "about", method: .get)
    }

    /// GET /settings
    public static func settings() -> Request<Settings> {
        Request(path: "settings", method: .get)
    }
}
