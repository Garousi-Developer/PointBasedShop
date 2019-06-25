import UIKit

class AddressesTableController: TableController {
    var addresses: [NewAddress] = []
    
    override func row(forCell cell: TableCell, atIndexPath indexPath: IndexPath) {
        super.row(forCell: cell, atIndexPath: indexPath)
        
        addresses = data as! [NewAddress]
        let castedCell = cell as! AddressTableCell
        let address = addresses[indexPath.row]
        
        castedCell.addressLabel.text = address.address
        castedCell.selectedSwitch.setOn(address.isSelected, animated: false)
    }
    override func rowDidSelect(atIndexPath indexPath: IndexPath) {
        super.rowDidSelect(atIndexPath: indexPath)
        
        let castedCell = tableView.cellForRow(at: indexPath) as! AddressTableCell
        let address = addresses[indexPath.row]
        
        for row in 0..<tableView.numberOfRows(inSection: 0) {
            let castedCellElement = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! AddressTableCell
            let addressElement = addresses[row]
            
            if row != indexPath.row {
                addressElement.isSelected = false
                castedCellElement.selectedSwitch.setOn(false, animated: true)
            }
        }
        if !castedCell.selectedSwitch.isOn {
            address.isSelected = true
            castedCell.selectedSwitch.setOn(true, animated: true)
        }
    }
}
