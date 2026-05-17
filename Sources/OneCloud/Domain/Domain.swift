import Foundation

/// Domain object nested in `presentDomain` (`domain` schema).
public struct Domain: Codable, Equatable, Sendable, Identifiable {
    public var id: Int64 { domainId }

    public let domainId: Int64
    public let name: String?
    public let description: String?
    public let region: String?
    public let status: String?
    public let type: String?
    public let clusterName: String?
    public let createTime: String?
    public let publicURL: String?
    public let publicArpURL: String?
    public let webClientURL: String?
    public let webConfiguratorURL: String?
    public let additionalWebClientURL: String?
    public let additionalWebConfiguratorURL: String?
    public let licenseStatus: String?
    public let licenseType: String?
    public let isVisible: Bool?
    public let isService: Bool?
    public let userId: Int64?
    public let archivePath: String?
    public let backupsMaxCount: Int64?
    public let cloudAuthority: String?
    public let cloudConnKey: String?
    public let connServerName: String?
    public let emailLimit: Int64?
    public let eventLimit: Int64?
    public let failoverURL: String?
    public let isArchiveEncryptionPasswordSet: Bool?
    public let mmSize: Int64?
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
    public var isOnline: Bool {
        status?.lowercased() == "online"
    }
}
