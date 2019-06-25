class OrderData: Decodable {
    let orderNumber: String
    let transactionNumber: String
    let state: String
    let items: [OrderItem]
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case orderNumber = "order_number"
        case transactionNumber = "transaction_code"
        case state = "status"
        case items = "order_item"
        case address
    }
}
