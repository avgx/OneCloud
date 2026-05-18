import Foundation

public struct FieldDictionaryRequest: Equatable, Sendable {
    public let type: String
    public let name: String

    public init(type: String, name: String) {
        self.type = type
        self.name = name
    }
}

public extension EventField {
    var dictionaryRequest: FieldDictionaryRequest? {
        guard let dictionaryType else {
            return nil
        }

        return FieldDictionaryRequest(type: dictionaryType, name: name)
    }
}
