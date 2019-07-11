struct ClosestOffersParameters: Encodable {
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
