import Foundation

/// Cloud installation settings (`GET /settings`).
public struct Settings: Codable, Equatable, Sendable {
    public let installationType: String?
    public let isLicenseEnable: Bool?
    public let webclientAutoLogoutTTLMin: Int64?
    public let cloudUIAutoLogoutTTLMin: Int64?
    public let googleMapAPIKey: String?
    public let yandexMapAPIKey: String?
    public let mapboxAPIKey: String?
    public let mapboxTilesSrc: String?
    public let openStreetMapAPIKey: String?
    public let openStreetMapTilesSrc: String?
    public let platformCalculatorURL: String?
    public let nasSelectionForManagedDomain: Bool?
}
