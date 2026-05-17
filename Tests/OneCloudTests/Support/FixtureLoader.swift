import Foundation
import Testing

enum FixtureLoader {
    static func loadData(resource: String, ext: String = "json") throws -> Data {
        let url = try #require(Bundle.module.url(forResource: resource, withExtension: ext))
        return try Data(contentsOf: url)
    }

    static func decode<T: Decodable>(
        _ type: T.Type,
        resource: String,
        ext: String = "json",
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> T {
        let data = try loadData(resource: resource, ext: ext)
        return try decoder.decode(type, from: data)
    }
}
