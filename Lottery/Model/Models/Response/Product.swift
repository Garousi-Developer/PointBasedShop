import UIKit

class Product {
    let isUnlocked: Bool
    let requiredPoints: Int
    var isFavorite: Bool
    let picture: UIImage
    let name: String
    let price: Int
    let discountedPrice: Int
    let brandLogo: UIImage
    let brandName: String
    var orderCount: Int
    var numberOfSoldProducts: Int
    var numberOfProducts: Int
    
    init(
        isUnlocked: Bool,
        requiredPoints: Int,
        isFavorite: Bool,
        picture: UIImage,
        name: String,
        price: Int,
        discountedPrice: Int,
        brandLogo: UIImage,
        brandName: String,
        orderCount: Int = 0,
        numberOfSoldProducts: Int,
        numberOfProducts: Int
    ) {
        self.isUnlocked = isUnlocked
        self.requiredPoints = requiredPoints
        self.isFavorite = isFavorite
        self.picture = picture
        self.name = name
        self.price = price
        self.discountedPrice = discountedPrice
        self.brandLogo = brandLogo
        self.brandName = brandName
        self.orderCount = orderCount
        self.numberOfSoldProducts = numberOfSoldProducts
        self.numberOfProducts = numberOfProducts
    }
}
