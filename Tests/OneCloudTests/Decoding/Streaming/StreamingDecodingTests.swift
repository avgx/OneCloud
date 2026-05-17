import Foundation
import Testing
@testable import OneCloud

@Suite("Streaming decoding")
struct StreamingDecodingTests {
  @Test("decode streaming list from fixture")
  func streamingList() throws {
    let streams = try FixtureLoader.decode([StreamingInfo].self, resource: "streaming_list")
    #expect(streams.count == 1)
    #expect(streams[0].name == "test")
    #expect(streams[0].key.uuidString.lowercased() == "0d3d4db4-4bff-4177-8d97-7a1524d4a8ff")
    #expect(streams[0].rtmpLink?.hasPrefix("rtmp://example.com") == true)
  }
}
