struct UpdateProfileParameters: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let mobileNumber: String
    let verificationCode: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "fname"
        case lastName = "lname"
        case email
        case password
        case mobileNumber = "username"
        case verificationCode = "code"
    }
}
