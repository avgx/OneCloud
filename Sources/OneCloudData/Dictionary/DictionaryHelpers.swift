import Foundation

public extension EventFieldDescriptor {
    var dictionaryType: String? {
        let type = resultType ?? self.type
        switch type {
        case EventFieldResultType.dictionary.rawValue, EventFieldResultType.set.rawValue:
            return type
        default:
            return nil
        }
    }
}

public extension EventField {
    var dictionaryType: String? {
        descriptor.dictionaryType
    }
}

public extension FieldValues {
    var dictionary: [String: String] {
        Dictionary(uniqueKeysWithValues: result.map { value in
            (value.key, value.translation ?? value.value ?? value.key)
        })
    }
}
