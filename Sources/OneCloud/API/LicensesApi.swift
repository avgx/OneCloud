import Foundation
import RequestResponse

/// Licenses API (`licenses` tag).
public enum LicensesApi {
    /// GET /licenses
    public static func listFeatures() -> Request<[LicenseFeaturesResp]> {
        Request(path: "licenses", method: .get)
    }
}
