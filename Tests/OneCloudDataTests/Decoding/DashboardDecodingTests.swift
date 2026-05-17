import Testing
@testable import OneCloudData

@Suite("Dashboard decoding")
struct DashboardDecodingTests {
    @Test("decode dashboards array from fixture")
    func dashboards() throws {
        let list = try FixtureLoader.decode([Dashboard].self, resource: "dashboards")
        #expect(list.count == 1)
        #expect(list[0].id == "00000000-0000-0000-0000-000000000001")
        #expect(list[0].title == "Test Dashboard")
    }

    @Test("decode share token from fixture")
    func shareToken() throws {
        let token = try FixtureLoader.decode(ShareToken.self, resource: "share_token")
        #expect(token.shareToken == "mock-share-token")
    }
}
