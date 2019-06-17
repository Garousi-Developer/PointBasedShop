class NewAd: Decodable {
//    let id: Int
    let pictureURL: String
//    let linkType: String
    
    enum CodingKeys: String, CodingKey {
//        case id
        case pictureURL = "image"
//        case linkType = "type"
    }
}
