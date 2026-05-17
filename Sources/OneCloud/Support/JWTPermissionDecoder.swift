import Foundation
import JWTDecode

enum JWTPermissionDecoder {
    static func decodePermissionStorage(from jwt: String) throws -> UserPermissionStorage {
        let decoded = try decode(jwt: jwt)
        var storage = UserPermissionStorage()
        for (key, value) in decoded.body {
            if let bool = value as? Bool {
                storage[key] = bool
            }
        }
        return storage
    }

    static func userId(from jwt: String) -> Int64? {
        guard let decoded = try? decode(jwt: jwt) else { return nil }
        if let int = decoded["UserID"].integer {
            return Int64(int)
        }
        if let double = decoded["UserID"].double {
            return Int64(double)
        }
        return nil
    }
}
