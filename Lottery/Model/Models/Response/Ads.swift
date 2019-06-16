class Ads: Decodable {
    let first: NewAd
    let second: NewAd
    
    init(
        first: NewAd,
        second: NewAd
    ) {
        self.first = first
        self.second = second
    }
}
