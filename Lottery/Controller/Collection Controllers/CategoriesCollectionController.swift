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
}
