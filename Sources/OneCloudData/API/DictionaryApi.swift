import Foundation
import RequestResponse

/// Axxon Data dictionary (`/api/v1/ad-dictionary`)
/// use a separate `RequestBuilder` base URL.
public enum DictionaryApi {
    /// GET /events/fields
    public static func eventFields(lang: String? = nil) -> Request<[EventField]> {
        Request(path: "events/fields", method: .get, query: queryItems(lang: lang))
    }

    /// GET /events/tables
    public static func eventTables(lang: String? = nil) -> Request<[EventTable]> {
        Request(path: "events/tables", method: .get, query: queryItems(lang: lang))
    }

    /// GET /timeperiods
    public static func timePeriods(lang: String? = nil) -> Request<[TimePeriod]> {
        Request(path: "timeperiods", method: .get, query: queryItems(lang: lang))
    }
}

private extension DictionaryApi {
    static func queryItems(lang: String?) -> [(String, String?)]? {
        guard let lang else { return nil }
        return [("lang", lang)]
    }
}
