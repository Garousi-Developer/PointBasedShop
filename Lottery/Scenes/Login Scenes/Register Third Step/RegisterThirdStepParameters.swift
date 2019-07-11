struct RegisterThirdStepParameters: Encodable {
    let mobileNumber: String
    let password: String
    let firstName: String
    let lastName: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case mobileNumber = "username"
        case password
        case firstName = "fname"
        case lastName = "lname"
        case email
    }
}
