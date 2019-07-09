class Spec: Decodable {
    let persianKey: String
    let englishKey: String
    let persianValue: String
    let englishValue: String
    
    enum CodingKeys: String, CodingKey {
        case persianKey = "fa_key"
        case englishKey = "en_key"
        case persianValue = "fa_value"
        case englishValue = "en_value"
    }
}
