class NewProduct: Decodable {
    let id: Int
    let isLocked: Bool!
    let requiredPoints: Int
    var isFavorite: Bool!
    let pictureURL: String
    let persianTitle: String
    let englishTitle: String
    let price: Int
    let discountedPrice: Int
    let brand: NewBrand
    var orderCount = 0
    var soldCount: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case isLocked = "lock"
        case requiredPoints = "point"
        case isFavorite = "favorites"
        case pictureURL = "image"
        case persianTitle = "fa_title"
        case englishTitle = "en_title"
        case price = "del"
        case discountedPrice = "price"
        case brand
        case soldCount = "sold_count"
        case count
    }
}
