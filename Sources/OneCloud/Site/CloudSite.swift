import Foundation
import SafeEnum

/// Cloud branch site under a domain ("Device groups" in axxoncloud-ui).
///
/// Not the same as VMS camera groups (`OneGroup` / `GET /v1/groups/list`).
public struct CloudSite: Decodable, Equatable, Sendable, Identifiable {
    public let id: Int64
    public let name: String
    public let description: String
    public let address: String
    public let contacts: String
    public let archiveDepth: Int
    public let camerasCount: [String: Int]
    public let status: SafeEnum<CloudSiteStatus>
    public let error: CloudSiteError?
    public let objectsLimitExceededTime: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case address
        case contacts
        case archiveDepth
        case camerasCount
        case status
        case error
        case objectsLimitExceededTime
    }
}

/// Site lifecycle status from ac-backend.
public enum CloudSiteStatus: String, Sendable, Equatable, Codable {
    case creating
    case updating
    case deleting
    case deleted
    case error
    case active
    case notCreated = "not_created"
}

/// Optional site error payload.
public struct CloudSiteError: Decodable, Equatable, Sendable {
    public let description: String
    public let key: String
}
