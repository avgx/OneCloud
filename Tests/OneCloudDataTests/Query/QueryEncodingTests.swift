import Foundation
import Testing
@testable import OneCloudData

@Suite("Query encoding")
struct QueryEncodingTests {
    @Test("encode events list query with filters")
    func eventsListQuery() throws {
        let query = Query.eventsList(
            fields: [.eventID, .timeDatetime, .cameraName, .detectorType, .snapshotURL],
            filter: QueryFilter(
                clauses: [
                    .in(.camera, ["camera-anon-001", "camera-anon-002"]),
                    .in(.cloudDomain, [1001]),
                    .eq(.detectorType, "face")
                ],
                period: .userDefined(
                    from: "2026-05-17T00:00:00Z",
                    to: "2026-05-18T00:00:00Z",
                    timeZone: "UTC"
                )
            ),
            limit: 50,
            offset: 100
        )

        let json = try encodedJSONObject(query)
        #expect(json["table"] as? String == EventTableName.events.rawValue)
        #expect(json["view"] as? String == "fields")
        #expect(json["limit"] as? Int == 50)
        #expect(json["offset"] as? Int == 100)

        let fields = try #require(json["fields"] as? [[String: Any]])
        #expect(fields[0]["field"] as? String == EventFieldName.eventID.rawValue)

        let filter = try #require(json["filter"] as? [String: Any])
        let clauses = try #require(filter["clauses"] as? [[String: Any]])
        #expect(clauses.count == 3)
        #expect(clauses[0]["op"] as? String == "in")

        let period = try #require(filter["period"] as? [String: Any])
        #expect(period["type"] as? String == TimePeriodKind.userDefined.rawValue)
        #expect(period["timeZone"] as? String == "UTC")
    }

    @Test("encode aggregation query")
    func aggregationQuery() throws {
        let query = Query.aggregation(
            groupBy: [.datetimeHour],
            measure: .eventVersion,
            aggregation: .count,
            filter: QueryFilter(period: Period(.today)),
            orderBy: [.asc(.datetimeHour)],
            limit: 1000
        )

        let json = try encodedJSONObject(query)
        let groupBy = try #require(json["groupBy"] as? [String])
        #expect(groupBy == [EventFieldName.datetimeHour.rawValue])

        let fields = try #require(json["fields"] as? [[String: Any]])
        #expect(fields[0]["field"] as? String == EventFieldName.datetimeHour.rawValue)
        #expect(fields[1]["field"] as? String == EventFieldName.eventVersion.rawValue)
        #expect(fields[1]["aggregationFunc"] as? String == Aggregation.count.rawValue)
        #expect(fields[1]["alias"] as? String == Aggregation.count.alias)

        let orderBy = try #require(json["orderBy"] as? [[String: Any]])
        #expect(orderBy[0]["field"] as? String == EventFieldName.datetimeHour.rawValue)
        #expect(orderBy[0]["desc"] as? Bool == false)
    }

    @Test("build events data and table count helper queries")
    func helperQueries() throws {
        let events = Query.eventsData(
            cameras: ["camera-anon-001"],
            domainIDs: [1001],
            detectorTypes: ["face"],
            period: Period(.today),
            limit: 25
        )
        let eventsJSON = try encodedJSONObject(events)
        let eventsFilter = try #require(eventsJSON["filter"] as? [String: Any])
        let clauses = try #require(eventsFilter["clauses"] as? [[String: Any]])
        #expect(clauses.count == 3)
        #expect(eventsJSON["limit"] as? Int == 25)

        let count = Query.tableCount(filter: QueryFilter(period: Period(.today)))
        let countJSON = try encodedJSONObject(count)
        let fields = try #require(countJSON["fields"] as? [[String: Any]])
        #expect(countJSON["limit"] as? Int == 1)
        #expect(fields[0]["aggregationFunc"] as? String == Aggregation.count.rawValue)
    }

    @Test("typed enum raw values match API strings")
    func enumRawValues() {
        #expect(EventTableName.posEvents.rawValue == "pos_events")
        #expect(EventTableName.auditEvents.rawValue == "audit_events")
        #expect(TimePeriodKind.last24Hours.rawValue == "last_24_hours")
        #expect(TimePeriodKind.dayBeforeYesterday.rawValue == "day_before_yesterday")
        #expect(EventFieldName.cloudDomain.rawValue == "cloud.domain")
        #expect(EventFieldName.originalSnapshotURL.rawValue == "original_snapshot_url")
    }
}

private func encodedJSONObject<T: Encodable>(_ value: T) throws -> [String: Any] {
    let data = try JSONEncoder().encode(value)
    let object = try JSONSerialization.jsonObject(with: data)
    return try #require(object as? [String: Any])
}
