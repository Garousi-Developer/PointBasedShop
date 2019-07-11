struct RegisterFirstStepParameters: Encodable {
    let mobileNumber: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case mobileNumber = "username"
        case password
    }
}
