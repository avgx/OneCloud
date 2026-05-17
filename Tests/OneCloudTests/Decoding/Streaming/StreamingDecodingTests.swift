import Foundation
import Testing
@testable import OneCloud

@Suite("Streaming decoding")
struct StreamingDecodingTests {
  @Test("decode streaming list from fixture")
  func streamingList() throws {
    let streams = try FixtureLoader.decode([StreamingInfo].self, resource: "streaming_list")
    #expect(streams.count == 1)
    #expect(streams[0].name == "Stream 1")
    #expect(streams[0].key.uuidString.lowercased() == "550e8400-e29b-41d4-a716-446655440000")
  }
}
