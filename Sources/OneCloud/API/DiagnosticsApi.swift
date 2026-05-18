import Foundation
import RequestResponse

/// Diagnostics API
public enum DiagnosticsApi {
    /// GET /diagnostics/summary
    public static func summary() -> Request<[DomainObjectsAmount]> {
        Request(path: "diagnostics/summary", method: .get)
    }
}
