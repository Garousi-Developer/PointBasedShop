class NewCity: Decodable {
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
    
    init(
        id: Int,
        pictureURL: String,
        persianTitle: String,
        englishTitle: String
    ) {
        self.id = id
        self.pictureURL = pictureURL
        self.persianTitle = persianTitle
        self.englishTitle = englishTitle
    }
}
