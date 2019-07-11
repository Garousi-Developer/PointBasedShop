struct ClaimPointsParameters: Encodable {
    let shoppingCenterId: Int
    let purchaseAmount: Int
    let employeeId: Int
    let secretToken: String
    
    enum CodingKeys: String, CodingKey {
        case shoppingCenterId = "shop_id"
        case purchaseAmount = "amount"
        case employeeId = "employee_id"
        case secretToken = "code"
    }
}
