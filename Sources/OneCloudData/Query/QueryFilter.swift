import Foundation

public struct QueryFilter: Codable, Equatable, Sendable {
    public var version: Int?
    public var clauses: [Clause]?
    public var period: Period?
    public var search: String?

    public init(
        version: Int? = 0,
        clauses: [Clause]? = nil,
        period: Period? = nil,
        search: String? = nil
    ) {
        self.version = version
        self.clauses = clauses
        self.period = period
        self.search = search
    }
}
