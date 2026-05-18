import Testing
@testable import OneCloudData

@Suite("Dictionary decoding")
struct DictionaryDecodingTests {
    @Test("decode event fields from anonymized real fixture")
    func eventFields() throws {
        let fields = try FixtureLoader.decode([EventField].self, resource: "event_fields.real.anonymized")
        let camera = try #require(fields.first { $0.name == EventFieldName.camera.rawValue })

        #expect(fields.count > 100)
        #expect(camera.descriptor.type == EventFieldResultType.dictionary.rawValue)
        #expect(camera.dictionaryType == EventFieldResultType.dictionary.rawValue)
        #expect(camera.dictionaryRequest?.name == EventFieldName.camera.rawValue)
    }

    @Test("decode event tables from anonymized real fixture")
    func eventTables() throws {
        let tables = try FixtureLoader.decode([EventTable].self, resource: "event_tables.real.anonymized")

        #expect(tables.map(\.name) == EventTableName.allCases.map(\.rawValue))
        #expect(tables.first { $0.name == EventTableName.events.rawValue }?.description == "Detectors events")
    }

    @Test("decode time periods from anonymized real fixture")
    func timePeriods() throws {
        let periods = try FixtureLoader.decode([TimePeriod].self, resource: "timeperiods.real.anonymized")

        #expect(periods.contains { $0.type == TimePeriodKind.today.rawValue })
        #expect(periods.contains { $0.compare == true })
        #expect(periods[0].tag.type == "other")
    }

    @Test("decode field values from anonymized real fixture")
    func fieldValues() throws {
        let values = try FixtureLoader.decode(FieldValues.self, resource: "field_values_camera.real.anonymized")

        #expect(values.status == 200)
        #expect(values.total == values.result.count)
        #expect(values.result.count > 100)
        #expect(values.result[0].key == "camera-value-anon-001")
        #expect(values.dictionary["camera-value-anon-001"] == "Camera 1")
    }
}
