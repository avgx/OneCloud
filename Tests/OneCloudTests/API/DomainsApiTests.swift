import Foundation
import RequestResponse
import Testing
@testable import OneCloud

@Suite("DomainsApi requests")
struct DomainsApiTests {
  private let builder = RequestBuilder.json(
    baseURL: URL(string: "https://cloud.example/api/v3/ac-backend")!,
    encoder: JSONEncoder()
  )

  @Test("list builds relative domains URL with pagination")
  func listURL() throws {
    let request = DomainsApi.list(offset: 10, limit: 50)
    let url = try builder.url(for: request)
    #expect(url.path.hasSuffix("/domains"))
    #expect(url.query?.contains("page%5Boffset%5D=10") == true || url.absoluteString.contains("page[offset]=10"))
  }

  @Test("get builds domain id path")
  func getURL() throws {
    let url = try builder.url(for: DomainsApi.get(domainId: 99))
    #expect(url.path.hasSuffix("/domains/99"))
  }

  @Test("webClientURL uses public path")
  func webClientURL() throws {
    let url = try builder.url(for: DomainsApi.webClientURL(domainId: 1))
    #expect(url.path.contains("public/domains/1/webclienturl"))
  }
}
