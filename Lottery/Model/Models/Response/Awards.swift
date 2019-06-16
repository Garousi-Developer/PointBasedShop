class Awards: Decodable {
    let id: Int
    let pictureURL: String
    let persianTitle: String
    let englishTitle: String
    let checkInPoint: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case pictureURL = "image"
        case persianTitle = "fa_name"
        case englishTitle = "en_name"
        case checkInPoint = "point"
    }
}
