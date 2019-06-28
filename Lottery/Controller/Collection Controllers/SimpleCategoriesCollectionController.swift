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
        
        castedCell.titleLabel.text = languageIsPersian ? category.persianTitle : category.englishTitle
        castedCell.selectedSwitch.setOn(category.isSelected, animated: false)
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        let castedViewController = viewController as! FilterViewController
        let castedCell = collectionView.cellForItem(at: indexPath) as! SimpleCategoryCollectionCell
        
        categories[indexPath.item].isSelected.toggle()
        castedCell.selectedSwitch.setOn(categories[indexPath.item].isSelected, animated: true)
        
        var allCategoriesAreSelected = true
        for category in categories {
            if !category.isSelected {
                allCategoriesAreSelected = false
                break
            }
        }
        if allCategoriesAreSelected {
            castedViewController.allCategoriesSwitch.setOn(true, animated: true)
        }
        else {
            castedViewController.allCategoriesSwitch.setOn(false, animated: true)
        }
    }
}
