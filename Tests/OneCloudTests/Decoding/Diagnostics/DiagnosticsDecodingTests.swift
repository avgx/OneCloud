import Foundation
import Testing
@testable import OneCloud

@Suite("Diagnostics decoding")
struct DiagnosticsDecodingTests {
  @Test("decode diagnostics summary inline")
  func domainObjectsAmountInline() throws {
    let json = """
    [{"domainId":1,"nodes":[{"name":"node1","amount":{"cameras":4,"archives":2}}]}]
    """
    let summary = try JSONDecoder().decode([DomainObjectsAmount].self, from: Data(json.utf8))
    #expect(summary.count == 1)
    #expect(summary[0].nodes?.first?.amount?.cameras == 4)
  }

  @Test("decode diagnostics summary from fixture")
  func domainObjectsAmountFixture() throws {
    let summary = try FixtureLoader.decode([DomainObjectsAmount].self, resource: "diagnostics_summary")
    #expect(!summary.isEmpty)
    #expect(summary[0].nodes?.first?.name == "Node-1")
    #expect(summary[1].nodes?.first?.name == "Node-2")
  }
}
