class SimpleCategory: Decodable {
    let id: Int
    let persianTitle: String
    let englishTitle: String
    var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case persianTitle = "fa_title"
        case englishTitle = "en_title"
    }
}
