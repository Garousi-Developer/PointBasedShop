import UIKit

class AddressesTableController: TableController {
    var addresses: [Address] = []
    
    override func row(forCell cell: TableCell, atIndexPath indexPath: IndexPath) {
        super.row(forCell: cell, atIndexPath: indexPath)
        
        addresses = data as! [Address]
        let castedCell = cell as! AddressTableCell
        let address = addresses[indexPath.row]
        
        castedCell.addressLabel.text = address.address
        castedCell.selectedSwitch.setOn(address.isSelected, animated: false)
    }
}
