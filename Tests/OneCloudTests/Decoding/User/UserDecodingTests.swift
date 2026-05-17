import Foundation
import Testing
@testable import OneCloud

@Suite("User decoding")
struct UserDecodingTests {
  @Test("decode userWithPermissions and JWT permissions from fixture")
  func userWithPermissions() throws {
    let user = try FixtureLoader.decode(UserWithPermissions.self, resource: "user_with_permissions")
    #expect(user.user?.userId == 7)
    #expect(user.hasPermission(.canFace))
    #expect(user.hasPermission(.canLPR) == false)
  }
}
