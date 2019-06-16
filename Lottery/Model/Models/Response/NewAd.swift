class NewAd: Decodable {
//    let id: Int
    let pictureURL: String
//    let linkType: String
    
    enum CodingKeys: String, CodingKey {
//        case id
        case pictureURL = "image"
//        case linkType = "type"
    }
    
    init(
//        id: Int,
        pictureURL: String
//        linkType: String
    ) {
//        self.id = id
        self.pictureURL = pictureURL
//        self.linkType = linkType
    }
}
