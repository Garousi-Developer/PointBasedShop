struct AddFavoriteParameters: Encodable {
    let productId: Int
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
    }
}
