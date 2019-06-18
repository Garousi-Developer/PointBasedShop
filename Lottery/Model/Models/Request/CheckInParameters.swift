struct CheckInParameters: Encodable {
    let shoppingCenterId: Int
    
    enum CodingKeys: String, CodingKey {
        case shoppingCenterId = "shop_id"
    }
}
