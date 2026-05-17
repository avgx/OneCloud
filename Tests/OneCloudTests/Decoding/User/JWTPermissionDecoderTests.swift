import Testing
@testable import OneCloud

@Suite("JWT permission decoding")
struct JWTPermissionDecoderTests {
    @Test("decode permission storage from mock JWT")
    func permissionStorage() throws {
        let jwt = "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJjYW5GYWNlIjp0cnVlfQ."
        let storage = try JWTPermissionDecoder.decodePermissionStorage(from: jwt)
        #expect(storage["canFace"] == true)
    }

    @Test("read UserID claim from access token shape")
    func userIdClaim() {
        let jwt = "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJVc2VySUQiOjI0Mn0."
        #expect(JWTPermissionDecoder.userId(from: jwt) == 242)
    }
}
