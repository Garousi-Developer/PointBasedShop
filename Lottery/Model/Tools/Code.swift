import Foundation

extension Encodable {
    var json: JSON {
        let jsonData = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! JSON
        
        return json
    }
}
extension Decodable {
    static func model(_ jsonData: Data) -> Self {
        return try! JSONDecoder().decode(Self.self, from: jsonData)
    }
}
extension Settings {
    static func model() -> Settings {
        let url = Bundle.main.url(forResource: "Settings", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let model = try! PropertyListDecoder().decode(Settings.self, from: data)
        
        return model
    }
}

typealias JSON = [String: Any]
