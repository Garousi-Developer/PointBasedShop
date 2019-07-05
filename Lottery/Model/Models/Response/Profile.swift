class Profile: Decodable {
    var firstName: String
    var lastName: String
    let userLevel: String
    let userPoints: String
    var email: String
    var mobileNumber: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userLevel = "level"
        case userPoints = "point"
        case email
        case mobileNumber = "username"
    }
}
