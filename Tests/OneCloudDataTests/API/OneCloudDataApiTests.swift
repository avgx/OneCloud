import Testing
@testable import OneCloudData

@Suite("OneCloudData API requests")
struct OneCloudDataApiTests {
    @Test("dictionary request paths")
    func dictionaryRequests() {
        let fields = DictionaryApi.eventFields(lang: "en")
        #expect(fields.path == "events/fields")
        #expect(fields.method.rawValue == "GET")
        #expect(fields.query?.first?.0 == "lang")
        #expect(fields.query?.first?.1 == "en")

        #expect(DictionaryApi.eventTables().path == "events/tables")
        #expect(DictionaryApi.timePeriods().path == "timeperiods")
    }

    @Test("query request paths")
    func queryRequests() {
        let query = Query.eventsList(fields: [.eventID], limit: 1)

        let list = QueryApi.query(query, lang: "en")
        #expect(list.path == "query")
        #expect(list.method.rawValue == "POST")
        #expect(list.query?.contains { $0.0 == "lang" && $0.1 == "en" } == true)

        let preview = QueryApi.preview(query)
        #expect(preview.path == "query/preview")
        #expect(preview.method.rawValue == "POST")

        let batch = QueryApi.batch([query])
        #expect(batch.path == "query/batch")
        #expect(batch.method.rawValue == "POST")
    }

    @Test("field values request includes optional query")
    func fieldValuesRequest() {
        let dictionary = FieldDictionaryRequest(
            type: EventFieldResultType.dictionary.rawValue,
            name: EventFieldName.camera.rawValue
        )
        let request = QueryApi.fieldValues(
            dictionary,
            lang: "en",
            parentValue: "domain-anon"
        )

        #expect(request.path == "field/dictionary/camera")
        #expect(request.method.rawValue == "POST")
        #expect(request.query?.contains { $0.0 == "parentValue" && $0.1 == "domain-anon" } == true)
    }
}
