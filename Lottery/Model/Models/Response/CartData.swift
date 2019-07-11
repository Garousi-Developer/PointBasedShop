class CartData: Decodable {
    let products: [NewProduct]
    let count: Int
    let totalPrice: Double
    let earnedPoints: Double
    let addresses: [NewAddress]
    
    enum CodingKeys: String, CodingKey {
        case products
        case count
        case totalPrice = "total_price"
        case earnedPoints = "point_amount"
        case addresses
    }
}
