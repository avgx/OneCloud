import Foundation
import SafeEnum

/// Domain object nested in `presentDomain` (`domain` schema).
public struct Domain: Codable, Equatable, Sendable, Identifiable {
    public var id: Int64 { domainId }

    public let domainId: Int64
    public let name: String
    public let createTime: String
    public let emailLimit: Int64?
    public let eventLimit: Int64?
    public let isService: Bool
    public let isVisible: Bool
    public let licenseType: SafeEnum<ProductType>?
    public let mmSize: Int64?
    public let status: SafeEnum<Status>
    public let type: SafeEnum<DomainType>
    public let userId: Int64?

    public let description: String?
    public let region: String?
    public let clusterName: String?
    public let publicURL: String?
    public let publicArpURL: String?
    public let webClientURL: String?
    public let webConfiguratorURL: String?
    public let additionalWebClientURL: String?
    public let additionalWebConfiguratorURL: String?
    public let licenseStatus: SafeEnum<LicenseStatus>?
    public let archivePath: String?
    public let backupsMaxCount: Int64?
    public let cloudAuthority: String?
    public let cloudConnKey: String?
    public let connServerName: String?
    public let failoverURL: String?
    public let isArchiveEncryptionPasswordSet: Bool?
    public let saleSystemId: String?

    private enum CodingKeys: String, CodingKey {
        case domainId
        case name
        case description
        case region
        case status
        case type
        case clusterName
        case createTime
        case publicURL
        case publicArpURL
        case webClientURL
        case webConfiguratorURL
        case additionalWebClientURL
        case additionalWebConfiguratorURL
        case licenseStatus
        case licenseType
        case isVisible
        case isService
        case userId
        case archivePath
        case backupsMaxCount
        case cloudAuthority
        case cloudConnKey
        case connServerName
        case emailLimit
        case eventLimit
        case failoverURL
        case isArchiveEncryptionPasswordSet
        case mmSize
        case saleSystemId
    }
}

extension Domain {
    /// `LicenseServiceStatus` wire strings (`LS_*`).
    public enum LicenseStatus: String, Codable, Hashable, Sendable {
        case unknown = "LS_Unknown"
        case ok = "LS_OK"
        case noKey = "LS_NoKey"
        case invalidKey = "LS_InvalidKey"
        case mismatchingKey = "LS_MismatchingKey"
        case expired = "LS_Expired"
        case demoInactive = "LS_DemoInactive"
        case demoExpired = "LS_DemoExpired"
        case demoActive = "LS_DemoActive"
        case unavailable = "LS_Unavailable"
    }

    /// `ProductType` wire strings (numeric codes in JSON `licenseType`).
    public enum ProductType: String, Codable, Hashable, Sendable {
        case unknown = "0"
        case pro = "10"
        case start = "11"
        case free = "12"
        case enterprise = "13"
        case universe = "Universe"
    }

    /// Domain connectivity (`status`).
    public enum Status: String, Codable, Hashable, Sendable {
        case online
        case offline
    }

    /// Domain product type (`type`).
    public enum DomainType: String, Codable, Hashable, Sendable {
        case vmsOnSite = "vms/on-site"
        case vmsManaged = "vms/managed"
        case vmsIntellect = "vms/intellect"
    }

    public var isOnline: Bool {
        status.value == .online
    }
}
