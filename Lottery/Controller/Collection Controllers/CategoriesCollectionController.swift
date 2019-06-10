import UIKit

class CategoriesCollectionController: CollectionController {
    var categories: [Category] = []
    
    override func itemHeight() -> CGFloat {
        let spacings: CGFloat = 3 * 12
        let staticHeights: CGFloat = 60
        let dynamicHeights = fonts(.medium).firstLineHeight
        
        return scale * (spacings + staticHeights) + dynamicHeights
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        categories = sharedData[index] as! [Category]
        let castedCell = cell as! CategoryCollectionCell
        let category = categories[indexPath.item]
        
        castedCell.pictureImageView.image = category.picture
        castedCell.titleLabel.text = category.title
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        viewController.navigateTo(
            .filterResults,
            transferringData: FilterResults(
                title: categories[indexPath.item].title,
                results: [
                    Product(
                        isUnlocked: true,
                        requiredPoints: 50,
                        isFavorite: false,
                        picture: #imageLiteral(resourceName: "testProduct1"),
                        name: "دوچرخه",
                        price: 6500000,
                        discountedPrice: 5200000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand1"),
                        orderCount: 0,
                        numberOfSoldProducts: 320,
                        numberOfProducts: 375
                    ),
                    Product(
                        isUnlocked: true,
                        requiredPoints: 40,
                        isFavorite: false,
                        picture: #imageLiteral(resourceName: "testProduct2"),
                        name: "کیف زنانه",
                        price: 620000,
                        discountedPrice: 500000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand2"),
                        orderCount: 0,
                        numberOfSoldProducts: 249,
                        numberOfProducts: 385
                    ),
                    Product(
                        isUnlocked: true,
                        requiredPoints: 110,
                        isFavorite: true,
                        picture: #imageLiteral(resourceName: "testProduct3"),
                        name: "مرسدس بنز",
                        price: 4000000000,
                        discountedPrice: 3200000000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand3"),
                        orderCount: 0,
                        numberOfSoldProducts: 339,
                        numberOfProducts: 1125
                    ),
                    Product(
                        isUnlocked: true,
                        requiredPoints: 75,
                        isFavorite: false,
                        picture: #imageLiteral(resourceName: "testProduct4"),
                        name: "ساعت مچی",
                        price: 3400000,
                        discountedPrice: 2700000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand4"),
                        orderCount: 0,
                        numberOfSoldProducts: 97,
                        numberOfProducts: 175
                    ),
                    Product(
                        isUnlocked: false,
                        requiredPoints: 150,
                        isFavorite: true,
                        picture: #imageLiteral(resourceName: "testProduct5"),
                        name: "تلویزیون",
                        price: 18000000,
                        discountedPrice: 14000000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand5"),
                        orderCount: 0,
                        numberOfSoldProducts: 102,
                        numberOfProducts: 200
                    )
                ]
            )
        )
    }
}
