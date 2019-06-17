class NewCategory: Decodable {
    let id: Int
    let pictureURL: String
    let persianTitle: String
    let englishTitle: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case pictureURL = "image"
        case persianTitle = "fa_name"
        case englishTitle = "en_name"
    }
}
