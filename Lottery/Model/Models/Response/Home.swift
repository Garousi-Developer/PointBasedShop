class Home: Decodable {
    let sliderAds: [NewAd]
    let categories: [NewCategory]
    let ads: Ads
    let cities: [NewCity]
    let topShoppingCenters: [NewShoppingCenter]
    let topBrands: [NewBrand]
    let userPoints: Double
    
    enum CodingKeys: String, CodingKey {
        case sliderAds = "sliders"
        case categories
        case ads = "advertises"
        case cities
        case topShoppingCenters = "shops"
        case topBrands = "brands"
        case userPoints = "point"
    }
}
