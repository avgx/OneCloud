import Foundation

/// Dashboard from ad-backend (`GET /users/my/dashboards`).
public struct Dashboard: Codable, Equatable, Sendable, Identifiable {
    public let id: String
    public let title: String?
    public let description: String?
    public let tags: String?
    public let lang: String?
    public let version: Int?
    public let revision: String?
    public let serviceMode: Bool?
    public let owner: Int64?
    public let widgets: [DashboardWidget]?
    public let layout: [String: [DashboardLayoutItem]]?
    public let style: [String: String]?
    public let commonFilterValue: DashboardCommonFilter?
}

public struct DashboardWidget: Codable, Equatable, Sendable {
    public let id: String?
    public let title: String?
    public let description: String?
}

public struct DashboardLayoutItem: Codable, Equatable, Sendable {
    public let h: Int?
    public let w: Int?
    public let x: Int?
    public let y: Int?
    public let i: String?
}

public struct DashboardCommonFilter: Codable, Equatable, Sendable {
    public let fields: [String]?
    public let clauses: [String]?
    public let periods: [String]?
}

public struct ShareToken: Codable, Equatable, Sendable {
    public let shareToken: String
}
