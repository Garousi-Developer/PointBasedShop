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
        
        castedCell.nameLabel.text = city.name
        castedCell.selectedSwitch.setOn(city.isSelected, animated: false)
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        
    }
}
