struct AddOrderParameters: Encodable {
    let charity: Bool
    let addressId: Int
    
    enum CodingKeys: String, CodingKey {
        case charity
        case addressId = "address_id"
    }
}
