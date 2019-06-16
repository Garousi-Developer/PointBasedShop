class ShoppingCenterDetails: Decodable {
    let id: Int
    let logoURL: String
    let pictureURL: String
    let persianTitle: String
    let englishTitle: String
    let persianCityTitle: String
    let englishCityTitle: String
    let persianDescription: String
    let englishDescription: String
    let topBrands: [NewShoppingCenter]
    let latitude: String
    let longitude: String
    let hottestOffers: [NewProduct]
    let ad: NewAd
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoURL = "logo"
        case pictureURL = "image"
        case persianTitle = "fa_title"
        case englishTitle = "en_title"
        case persianCityTitle = "fa_city"
        case englishCityTitle = "en_city"
        case persianDescription = "fa_description"
        case englishDescription = "en_description"
        case topBrands = "brands"
        case latitude = "lat"
        case longitude = "lng"
        case hottestOffers = "products"
        case ad = "advertise"
    }
}
