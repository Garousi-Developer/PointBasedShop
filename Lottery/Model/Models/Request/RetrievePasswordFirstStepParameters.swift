struct RetrievePasswordFirstStepParameters: Encodable {
    let mobileNumber: String
    
    enum CodingKeys: String, CodingKey {
        case mobileNumber = "username"
    }
}