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

  @Test("list with limit 2 and offset 2 builds page query")
  func listPagingURL() throws {
    let url = try builder.url(for: DomainsApi.list(offset: 2, limit: 2))
    let query = url.query ?? ""
    #expect(query.contains("page%5Blimit%5D=2") || query.contains("page[limit]=2"))
    #expect(query.contains("page%5Boffset%5D=2") || query.contains("page[offset]=2"))
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
