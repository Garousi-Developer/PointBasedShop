struct InviteParameters: Encodable {
    let mobileNumber: String
    
    enum CodingKeys: String, CodingKey {
        case mobileNumber = "phone"
    }
}
