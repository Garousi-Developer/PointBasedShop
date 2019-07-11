struct RegisterSecondStepParameters: Encodable {
    let mobileNumber: String
    let verificationCode: Int
    
    enum CodingKeys: String, CodingKey {
        case mobileNumber = "username"
        case verificationCode = "code"
    }
}
