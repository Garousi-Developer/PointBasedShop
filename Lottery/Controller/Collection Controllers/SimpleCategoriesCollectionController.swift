import UIKit

class SimpleCategoriesCollectionController: CollectionController {
    var categories: [SimpleCategory] = []
    
    override func itemHeight() -> CGFloat {
        return 31
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        categories = data as! [SimpleCategory]
        let castedCell = cell as! SimpleCategoryCollectionCell
        let category = categories[indexPath.item]
        
        castedCell.titleLabel.text = category.title
        castedCell.selectedSwitch.setOn(category.isSelected, animated: false)
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
//        let castedCell = collectionView.cellForItem(at: indexPath) as! SimpleCategoryCollectionCell
//
//        categories[indexPath.item].isSelected.toggle()
//        delay(durations(.interaction)) {
//            self.collectionView.reloadItems(at: [indexPath])
//            castedCell.selectedSwitch.setOn(self.categories[indexPath.item].isSelected, animated: false)
//        }
    }
}
