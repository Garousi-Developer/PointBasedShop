class NewProduct: Decodable {
    let id: Int
    let isLocked: Bool!
    let requiredPoints: Int
    var isFavorite: Bool!
    let pictureURL: String
    let persianTitle: String
    let englishTitle: String
    let price: Int
    let discountedPrice: Double
    let brand: NewBrand
    var orderCount: Int!
    var soldCount: Int
    let count: Int
    let persianDescription: String!
    let englishDescription: String!
    
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
        case orderCount = "cart"
        case soldCount = "sold_count"
        case count
        case persianDescription = "fa_description"
        case englishDescription = "en_description"
    }
}
