class NewAddress: Decodable {
    let id: Int
    let address: String
    var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case address
    }
}
