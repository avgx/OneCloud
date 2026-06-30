import Foundation
import SafeEnum

/// Domain product type (`type`).
public enum DomainType: String, Codable, Hashable, Sendable {
    case vmsOnSite = "vms/on-site"
    case vmsManaged = "vms/managed"
    case vmsIntellect = "vms/intellect"
}
