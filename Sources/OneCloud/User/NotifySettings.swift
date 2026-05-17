import Foundation

public struct NotifySettings: Codable, Equatable, Sendable {
    public let needNotify: Bool?
    public let notifyBefore: Int64?
}
