class ProductDetails: Decodable {
    let product: NewProduct
    let specs: [Spec]
    
    enum CodingKeys: String, CodingKey {
        case product
        case specs = "properties"
    }
}
