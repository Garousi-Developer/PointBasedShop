class BrandDetails: Decodable {
//    let id: Int
    let logoURL: String
    let pictureURL: String
    let persianTitle: String
    let englishTitle: String
    let persianDescription: String
    let englishDescription: String
//    let latitude: String
//    let longitude: String
    let ad: NewAd
    
    enum CodingKeys: String, CodingKey {
//        case id
        case logoURL = "logo"
        case pictureURL = "image"
        case persianTitle = "fa_name"
        case englishTitle = "en_name"
        case persianDescription = "fa_description"
        case englishDescription = "en_description"
//        case latitude = "lat"
//        case longitude = "lng"
        case ad = "advertise"
    }
}
