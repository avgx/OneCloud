import Foundation
import Testing
@testable import OneCloud

@Suite("License decoding")
struct LicenseDecodingTests {
  @Test("decode license keys inline")
  func userLicenseKeys() throws {
    let json = """
    {
      "personalKeys": [{
        "id": 1,
        "name": "Key",
        "saleSystemId": "SS1",
        "expireTime": "2025-12-31T00:00:00Z",
        "domainsCount": 2,
        "notificationExists": false,
        "cameraStats": {"total": 10, "used": 3}
      }],
      "sharedKeys": []
    }
    """
    let keys = try JSONDecoder().decode(UserLicenseKeysWithCameraStats.self, from: Data(json.utf8))
    #expect(keys.personalKeys?.count == 1)
    #expect(keys.personalKeys?.first?.cameraStats?.used == 3)
  }

  @Test("decode license features inline")
  func licenseFeatures() throws {
    let json = #"{"id":5,"name":"feature","quota":100,"sharedQuota":50}"#
    let feature = try JSONDecoder().decode(LicenseFeaturesResp.self, from: Data(json.utf8))
    #expect(feature.licenseId == 5)
    #expect(feature.quota == 100)
  }
}
