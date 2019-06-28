import UIKit

class CategoriesCollectionController: CollectionController {
    var categories: [NewCategory] = []
    
    override func itemHeight() -> CGFloat {
        let spacings: CGFloat = 3 * 12
        let staticHeights: CGFloat = 60
        let dynamicHeights = fonts(.medium).firstLineHeight
        
        return scale * (spacings + staticHeights) + dynamicHeights
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        categories = data as! [NewCategory]
        let castedCell = cell as! CategoryCollectionCell
        let category = categories[indexPath.item]
        
        castedCell.pictureImageView.downloadImageFrom(category.pictureURL)
        castedCell.titleLabel.text = languageIsPersian ? category.persianTitle : category.englishTitle
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        viewController.navigateTo(
            .filterResults,
            transferringData: categories[indexPath.item]
        )
    }
}
