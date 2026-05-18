import Testing
@testable import OneCloudData

@Suite("Query decoding")
struct QueryDecodingTests {
    @Test("decode events query response from anonymized real fixture")
    func eventsResponse() throws {
        let response = try FixtureLoader.decode(QueryResponse.self, resource: "query_events.real.anonymized")

        #expect(response.delta?.intValue == 0)
        #expect(response.result.count == 5)
        #expect(response.result[0][EventFieldName.eventID.rawValue]?.stringValue == "uuid-anonymized")
        #expect(response.result[0][EventFieldName.cloudDomain.rawValue]?.intValue != nil)
        #expect(response.allKeys.contains(EventFieldName.camera.rawValue))

        let fields = try FixtureLoader.decode([EventField].self, resource: "event_fields.real.anonymized")
        #expect(response.dictionaryRequests(from: fields).contains { $0.name == EventFieldName.camera.rawValue })
    }

    @Test("decode aggregation response from anonymized real fixture")
    func aggregationResponse() throws {
        let response = try FixtureLoader.decode(QueryResponse.self, resource: "query_aggregation.real.anonymized")

        #expect(response.result.count == 28)
        #expect(response.delta?.intValue == 0)
        #expect(response.countValue > 0)
    }

    @Test("decode query preview from anonymized real fixture")
    func previewResponse() throws {
        let preview = try FixtureLoader.decode(QueryPreview.self, resource: "query_preview.real.anonymized")

        #expect(preview.text?.localizedCaseInsensitiveContains("select") == true)
        #expect(preview.args?.last?.intValue == 1000)
    }

    @Test("decode batch response from anonymized real fixture")
    func batchResponse() throws {
        let response = try FixtureLoader.decode(QueryBatchResponse.self, resource: "query_batch.real.anonymized")

        #expect(response.delta?.intValue == 0)
        #expect(response.result.count == 2)
        #expect(response.result[0].count == 5)
        #expect(response.result[1].count == 28)
    }
}
