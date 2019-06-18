class Awards: Decodable {
    let id: Int
    let pictureURL: String
    let persianTitle: String
    let englishTitle: String
    let checkInPoint: String
    let ad: NewAd
    
    enum CodingKeys: String, CodingKey {
        case id
        case pictureURL = "image"
        case persianTitle = "fa_name"
        case englishTitle = "en_name"
        case checkInPoint = "bonus"
        case ad = "advertise"
    }
}
