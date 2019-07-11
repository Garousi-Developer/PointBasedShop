struct RemoveFavoriteParameters: Encodable {
    let productIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case productIds = "product_id"
    }
}
