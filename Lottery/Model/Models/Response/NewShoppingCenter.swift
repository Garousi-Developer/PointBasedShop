class NewShoppingCenter: Decodable {
    let id: Int
    let logoURL: String
    let persianTitle: String
    let englishTitle: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoURL = "logo"
        case persianTitle = "fa_name"
        case englishTitle = "en_name"
    }
}
