import Foundation
import RequestResponse

/// Streaming API (`streaming` tag).
public enum StreamingApi {
    /// GET /streaming
    public static func list() -> Request<[StreamingInfo]> {
        Request(path: "streaming", method: .get)
    }

    /// POST /streaming
    public static func create() -> Request<StreamingInfo> {
        Request(path: "streaming", method: .post)
    }

    /// GET /streaming/keys/{key}
    public static func get(key: UUID) -> Request<StreamingInfo> {
        Request(path: "streaming/keys/\(key.uuidString)", method: .get)
    }

    /// PATCH /streaming/keys/{key}
    public static func rename(key: UUID, name: String) -> Request<OK> {
        Request(
            path: "streaming/keys/\(key.uuidString)",
            method: .patch,
            query: [("name", name)]
        )
    }

    /// DELETE /streaming/keys/{key}
    public static func delete(key: UUID) -> Request<OK> {
        Request(path: "streaming/keys/\(key.uuidString)", method: .delete)
    }
}
