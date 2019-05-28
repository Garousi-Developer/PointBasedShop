import UIKit

struct Product {
    let requiredPoints: Int
    var isFavorite: Bool
    let picture: UIImage
    let name: String
    let price: Int
    let discountedPrice: Int
    let brandLogo: UIImage
    var orderCount: Int = 0
    let numberOfSoldProducts: Int
    let numberOfProducts: Int
}
