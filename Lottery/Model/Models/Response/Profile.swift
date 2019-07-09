class Profile: Decodable {
    var firstName: String
    var lastName: String
    let userLevel: String
    let userPoints: String
    let facebook: String
    let instagram: String
    let twitter: String
    let linkedin: String
    let youtube: String
    var registerationDate: String
    var email: String
    var mobileNumber: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userLevel = "level"
        case userPoints = "point"
        case facebook
        case instagram
        case twitter
        case linkedin
        case youtube
        case registerationDate = "date"
        case email
        case mobileNumber = "username"
    }
}
