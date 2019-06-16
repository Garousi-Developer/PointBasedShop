class ClosestOffers: Decodable {
    let offers: [NewProduct]
    
    enum CodingKeys: String, CodingKey {
        case offers = "data"
    }
    
    init(
        offers: [NewProduct]
    ) {
        self.offers = offers
    }
}
