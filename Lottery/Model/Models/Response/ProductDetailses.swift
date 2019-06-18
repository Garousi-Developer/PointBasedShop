class ProductDetailses: Decodable {
    let productDetails: ProductDetails
    
    enum CodingKeys: String, CodingKey {
        case productDetails = "data"
    }
}
