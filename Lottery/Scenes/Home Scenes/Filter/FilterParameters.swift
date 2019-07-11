struct FilterParameters: Encodable {
    let searchedPhrase: String
    let categories: [Int]
    let cities: [Int]
    let lockState: String
    
    enum CodingKeys: String, CodingKey {
        case searchedPhrase = "word"
        case categories
        case cities
        case lockState = "lock_status"
    }
}
