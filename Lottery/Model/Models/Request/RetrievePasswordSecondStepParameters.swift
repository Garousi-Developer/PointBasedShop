struct RetrievePasswordSecondStepParameters: Encodable {
    let mobileNumber: String
    let verificationCode: String
    
    enum CodingKeys: String, CodingKey {
        case mobileNumber = "username"
        case verificationCode = "code"
    }
}
