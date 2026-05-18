import Foundation

public enum EventTableName: String, Codable, Sendable, CaseIterable {
    case acfaEvents = "acfa_events"
    case alerts
    case analyzerEvents = "analyzer_events"
    case auditEvents = "audit_events"
    case events
    case posEvents = "pos_events"
    case psimEvents = "psim_events"
}
