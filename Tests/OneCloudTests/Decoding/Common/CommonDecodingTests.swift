import Foundation
import Testing
@testable import OneCloud

@Suite("Common decoding")
struct CommonDecodingTests {
  @Test("decode settings from fixture")
  func settings() throws {
    let settings = try FixtureLoader.decode(Settings.self, resource: "settings")
    #expect(settings.installationType == "cloud")
    #expect(settings.isLicenseEnable == true)
  }

  @Test("decode OK inline")
  func ok() throws {
    let ok = try JSONDecoder().decode(OK.self, from: Data(#"{"description":"ok"}"#.utf8))
    #expect(ok.description == "ok")
  }

  @Test("decode public web client URL inline")
  func publicWebClientURL() throws {
    let url = try JSONDecoder().decode(
      PublicWebClientURL.self,
      from: Data(#"{"publicURL":"https://example/client"}"#.utf8)
    )
    #expect(url.publicURL == "https://example/client")
  }
}
