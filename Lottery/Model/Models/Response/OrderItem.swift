class OrderItem: Decodable {
    let pictureURL: String
    let persianTitle: String
    let englishTitle: String
    let count: Int
    let totalPrice: Int
    let totalPoints: Int
    let brand: NewBrand
    
    enum CodingKeys: String, CodingKey {
        case pictureURL = "image"
        case persianTitle = "fa_title"
        case englishTitle = "en_title"
        case count = "in_cart"
        case totalPrice = "price"
        case totalPoints = "point"
        case brand
    }
}
