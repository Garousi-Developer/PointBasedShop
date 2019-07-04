class NewAddress: Decodable {
    var id: Int
    let address: String
    var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case address
    }
    
    init(
        id: Int,
        address: String
    ) {
        self.id = id
        self.address = address
    }
}
