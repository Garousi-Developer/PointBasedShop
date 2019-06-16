class CityDetails: Decodable {
    let id: Int
    let persianTitle: String
    let englishTitle: String
    let pictureURL: String
    let persianDescription: String
    let englishDescription: String
    let topShoppingCenters: [NewShoppingCenter]
    let latitude: String
    let longitude: String
    let hottestOffers: [NewProduct]
    let ad: NewAd
    
    enum CodingKeys: String, CodingKey {
        case id
        case persianTitle = "fa_name"
        case englishTitle = "en_name"
        case pictureURL = "image"
        case persianDescription = "fa_description"
        case englishDescription = "en_description"
        case topShoppingCenters = "top_shops"
        case latitude = "lat"
        case longitude = "long"
        case hottestOffers = "products"
        case ad = "advertise"
    }
}
