class Profile: Decodable {
    let firstName: String
    let lastName: String
    let userLevel: String
    let userPoints: Double
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userLevel = "level"
        case userPoints = "point"
    }
}
