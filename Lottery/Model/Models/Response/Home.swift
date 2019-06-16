class Home: Decodable {
    let sliderAds: [NewAd]
    let categories: [NewCategory]
    let ads: Ads
    let cities: [NewCity]
    let topShoppingCenters: [NewShoppingCenter]
    let topBrands: [NewBrand]
    let userPoints: Int
    
    enum CodingKeys: String, CodingKey {
        case sliderAds = "sliders"
        case categories
        case ads = "advertises"
        case cities
        case topShoppingCenters = "shops"
        case topBrands = "brands"
        case userPoints = "point"
    }
    
    init(
        sliderAds: [NewAd],
        categories: [NewCategory],
        ads: Ads,
        cities: [NewCity],
        topShoppingCenters: [NewShoppingCenter],
        topBrands: [NewBrand],
        userPoints: Int
    ) {
        self.sliderAds = sliderAds
        self.categories = categories
        self.ads = ads
        self.cities = cities
        self.topShoppingCenters = topShoppingCenters
        self.topBrands = topBrands
        self.userPoints = userPoints
    }
}
