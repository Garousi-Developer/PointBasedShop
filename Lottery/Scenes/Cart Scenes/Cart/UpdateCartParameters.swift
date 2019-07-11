struct UpdateCartParameters: Encodable {
    let productIds: [Int]
    let updateType: String
    
    enum CodingKeys: String, CodingKey {
        case productIds = "products_id"
        case updateType = "type"
    }
}
