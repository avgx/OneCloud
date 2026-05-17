import Foundation

public struct LicenseFeaturesResp: Codable, Equatable, Sendable, Identifiable {
    public var id: Int64 { licenseId ?? 0 }

    public let licenseId: Int64?
    public let name: String?
    public let quota: Int64?
    public let sharedQuota: Int64?
    public let saleSystemId: String?
    public let expireTimeUtc: String?

    private enum CodingKeys: String, CodingKey {
        case licenseId = "id"
        case name
        case quota
        case sharedQuota
        case saleSystemId
        case expireTimeUtc
    }
}
