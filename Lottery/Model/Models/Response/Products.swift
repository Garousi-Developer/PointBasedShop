class Products: Decodable {
    let products: [NewProduct]
    
    enum CodingKeys: String, CodingKey {
        case products = "data"
    }
}
