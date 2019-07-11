import UIKit

class ProductDetailsTableController: TableController {
    var specs: [Spec] = []
    
    override func row(forCell cell: TableCell, atIndexPath indexPath: IndexPath) {
        super.row(forCell: cell, atIndexPath: indexPath)
        
        specs = data as! [Spec]
        let castedCell = cell as! ProductDetailTableCell
        let spec = specs[indexPath.row]
        
        castedCell.keyLabel.text = languageIsPersian ? spec.persianKey : spec.englishKey
        castedCell.valueLabel.text = languageIsPersian ? spec.persianValue : spec.englishValue
    }
}
