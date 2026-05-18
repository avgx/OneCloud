import Foundation

public struct Query: Codable, Equatable, Sendable {
    public var view: String?
    public var fields: [QueryField]
    public var table: String?
    public var filter: QueryFilter?
    public var groupBy: [String]?
    public var having: [QueryHaving]?
    public var orderBy: [OrderBy]?
    public var limit: Int?
    public var offset: Int?
    public var distinct: Bool?
    public var distinctOn: [QueryField]?
    public var countRows: Bool?

    public init(
        view: String? = nil,
        fields: [QueryField],
        table: String? = nil,
        filter: QueryFilter? = nil,
        groupBy: [String]? = nil,
        having: [QueryHaving]? = nil,
        orderBy: [OrderBy]? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        distinct: Bool? = nil,
        distinctOn: [QueryField]? = nil,
        countRows: Bool? = nil
    ) {
        self.view = view
        self.fields = fields
        self.table = table
        self.filter = filter
        self.groupBy = groupBy
        self.having = having
        self.orderBy = orderBy
        self.limit = limit
        self.offset = offset
        self.distinct = distinct
        self.distinctOn = distinctOn
        self.countRows = countRows
    }
}

public extension Query {
    static func eventsList(
        table: EventTableName = .events,
        fields: [EventFieldName] = EventFieldName.defaultEventListFields,
        filter: QueryFilter? = nil,
        orderBy: [OrderBy]? = [.desc(.timeUTC)],
        limit: Int? = nil,
        offset: Int? = nil
    ) -> Query {
        Query(
            view: "fields",
            fields: fields.map { QueryField($0) },
            table: table.rawValue,
            filter: filter,
            orderBy: orderBy,
            limit: limit,
            offset: offset
        )
    }

    static func eventsData(
        cameras: [String] = [],
        domainIDs: [Int] = [],
        detectorTypes: [String] = [],
        period: Period? = nil,
        limit: Int? = nil,
        offset: Int? = nil,
        fields: [EventFieldName] = EventFieldName.defaultEventListFields
    ) -> Query {
        var clauses: [Clause] = []

        if !cameras.isEmpty {
            clauses.append(.in(.camera, cameras))
        }
        if !domainIDs.isEmpty {
            clauses.append(.in(.cloudDomain, domainIDs))
        }
        if !detectorTypes.isEmpty {
            clauses.append(.in(.detectorType, detectorTypes))
        }

        return eventsList(
            fields: fields,
            filter: QueryFilter(
                clauses: clauses.isEmpty ? nil : clauses,
                period: period
            ),
            limit: limit,
            offset: offset
        )
    }

    static func aggregation(
        table: EventTableName = .events,
        groupBy: [EventFieldName],
        measure: EventFieldName = .eventVersion,
        aggregation: Aggregation = .count,
        alias: String? = nil,
        filter: QueryFilter? = nil,
        orderBy: [OrderBy]? = nil,
        limit: Int? = nil
    ) -> Query {
        let bucketFields = groupBy.map { QueryField($0) }
        let aggregationField = QueryField(
            measure,
            alias: alias ?? aggregation.alias,
            aggregation: aggregation
        )

        return Query(
            view: "fields",
            fields: bucketFields + [aggregationField],
            table: table.rawValue,
            filter: filter,
            groupBy: groupBy.map(\.rawValue),
            orderBy: orderBy,
            limit: limit
        )
    }

    static func tableCount(
        table: EventTableName = .events,
        filter: QueryFilter? = nil,
        alias: String = Aggregation.count.alias
    ) -> Query {
        Query(
            view: "fields",
            fields: [.count(.eventVersion, alias: alias)],
            table: table.rawValue,
            filter: filter,
            limit: 1
        )
    }
}
