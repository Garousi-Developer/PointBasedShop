struct FilterParameters: Encodable {
    let categories: [Int]
    let cities: [Int]
    let searchedPhrase: String
    
    enum CodingKeys: String, CodingKey {
        case categories
        case cities
        case searchedPhrase = "word"
    }
}
