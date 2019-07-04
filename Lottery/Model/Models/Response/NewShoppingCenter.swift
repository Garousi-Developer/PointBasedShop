class NewShoppingCenter: Decodable {
    let id: Int
    let logoURL: String
    let persianTitle: String
    let englishTitle: String
    let latitude: String!
    let longitude: String!
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoURL = "logo"
        case persianTitle = "fa_name"
        case englishTitle = "en_name"
        case latitude = "lat"
        case longitude = "lng"
    }
}
