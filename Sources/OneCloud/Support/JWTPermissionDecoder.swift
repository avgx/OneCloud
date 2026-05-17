import Foundation

enum JWTPermissionDecoder {
    static func decodePermissionStorage(from jwt: String) throws -> UserPermissionStorage {
        let segments = jwt.split(separator: ".")
        guard segments.count >= 2 else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [], debugDescription: "Invalid JWT format")
            )
        }

        var base64 = String(segments[1])
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let padding = (4 - base64.count % 4) % 4
        if padding > 0 {
            base64 += String(repeating: "=", count: padding)
        }

        guard let data = Data(base64Encoded: base64) else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [], debugDescription: "Invalid JWT payload encoding")
            )
        }

        return try JSONDecoder().decode(UserPermissionStorage.self, from: data)
    }
}
