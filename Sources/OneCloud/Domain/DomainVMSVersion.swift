import Foundation

public struct DomainVMSVersion: Codable, Equatable, Sendable, Identifiable {
    public var id: Int64 { domainId }

    public let domainId: Int64
    public let domainName: String?
    public let domainType: String?  //TODO: SafeEnum
    public let domainIsVisible: Bool?
    public let domainIsService: Bool?
    public let vmsVersion: String?
}
