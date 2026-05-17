import Foundation
import RequestResponse

/// Domain licenses API (`domainLicenses` tag).
public enum DomainLicensesApi {
    /// GET /domain-licenses
    public static func list(
        searchAny: String? = nil,
        includeCameraStats: Bool = false
    ) -> Request<UserLicenseKeysWithCameraStats> {
        var query: [(String, String?)] = [
            ("cameraStats", "\(includeCameraStats)"),
        ]
        if let searchAny {
            query.append(("search[any]", searchAny))
        }
        return Request(path: "domain-licenses", method: .get, query: query)
    }
}
