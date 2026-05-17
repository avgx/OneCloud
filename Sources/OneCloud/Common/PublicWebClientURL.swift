import Foundation

/// Response for `GET /public/domains/{domainId}/webclienturl`.
public struct PublicWebClientURL: Codable, Equatable, Sendable {
    public let publicURL: String?

    private enum CodingKeys: String, CodingKey {
        case publicURL
    }
}
