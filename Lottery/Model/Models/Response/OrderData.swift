class OrderData: Decodable {
    let id: Int
    let orderNumber: String
    let totalPrice: String
    let status: String
    let transactionNumber: String
    let paymentDate: String
    let paymentTime: String
    let address: String
    let donated: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "order_number"
        case totalPrice = "final_price"
        case status
        case transactionNumber = "transaction_code"
        case paymentDate = "date"
        case paymentTime = "time"
        case address
        case donated = "donate"
    }
}
