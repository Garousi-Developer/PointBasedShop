import UIKit

class SimpleCitiesCollectionController: CollectionController {
    var cities: [SimpleCity] = []
    
    override func itemHeight() -> CGFloat {
        return 31
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        cities = data as! [SimpleCity]
        let castedCell = cell as! SimpleCityCollectionCell
        let city = cities[indexPath.item]
        
        castedCell.nameLabel.text = languageIsPersian ? city.persianTitle : city.englishTitle
        castedCell.selectedSwitch.setOn(city.isSelected, animated: false)
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        let castedViewController = viewController as! FilterViewController
        let castedCell = collectionView.cellForItem(at: indexPath) as! SimpleCityCollectionCell
        
        cities[indexPath.item].isSelected.toggle()
        castedCell.selectedSwitch.setOn(cities[indexPath.item].isSelected, animated: true)
        
        var allCitiesAreSelected = true
        for city in cities {
            if !city.isSelected {
                allCitiesAreSelected = false
                break
            }
        }
        if allCitiesAreSelected {
            castedViewController.allCitiesSwitch.setOn(true, animated: true)
        }
        else {
            castedViewController.allCitiesSwitch.setOn(false, animated: true)
        }
    }
}
