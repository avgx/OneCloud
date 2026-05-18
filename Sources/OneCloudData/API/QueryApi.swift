import Foundation
import RequestResponse

/// Axxon Data query (`/api/v2/ad-query`)
/// use a separate `RequestBuilder` base URL.
public enum QueryApi {
    /// POST /field/{type}/{name}
    public static func fieldValues(
        type: String,
        name: String,
        lang: String? = nil,
        parentValue: String? = nil,
        filter: QueryFilter? = nil
    ) -> Request<FieldValues> {
        Request(
            path: "field/\(type)/\(name)",
            method: .post,
            query: queryItems(lang: lang, parentValue: parentValue),
            body: filter
        )
    }

    /// POST /field/{type}/{name}
    public static func fieldValues(
        _ request: FieldDictionaryRequest,
        lang: String? = nil,
        parentValue: String? = nil,
        filter: QueryFilter? = nil
    ) -> Request<FieldValues> {
        fieldValues(
            type: request.type,
            name: request.name,
            lang: lang,
            parentValue: parentValue,
            filter: filter
        )
    }

    /// POST /query
    public static func query(
        _ query: Query,
        lang: String? = nil
    ) -> Request<QueryResponse> {
        Request(
            path: "query",
            method: .post,
            query: queryItems(lang: lang),
            body: query
        )
    }

    /// POST /query/preview
    public static func preview(
        _ query: Query,
        lang: String? = nil
    ) -> Request<QueryPreview> {
        Request(
            path: "query/preview",
            method: .post,
            query: queryItems(lang: lang),
            body: query
        )
    }

    /// POST /query/batch
    public static func batch(
        _ queries: [Query],
        lang: String? = nil
    ) -> Request<QueryBatchResponse> {
        Request(
            path: "query/batch",
            method: .post,
            query: queryItems(lang: lang),
            body: queries
        )
    }
}

private extension QueryApi {
    static func queryItems(
        lang: String? = nil,
        parentValue: String? = nil
    ) -> [(String, String?)]? {
        var items: [(String, String?)] = []

        if let lang {
            items.append(("lang", lang))
        }
        if let parentValue {
            items.append(("parentValue", parentValue))
        }
        return items.isEmpty ? nil : items
    }
}
