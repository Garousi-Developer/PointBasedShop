import UIKit

class EditableAddressesTableController: TableController {
    var addresses: [NewAddress]!
    var addAddressParameters: AddAddressParameters!
    var addAddressResponseController: AddAddressResponseController!
    var responseController: ResponseController!
    
    @objc func addressDidChange(sender: FirstTextField) {
        let castedCell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! EditableAddressTableCell
        if sender.text!.isEmpty {
            castedCell.editButton.disable()
        }
        else {
            castedCell.editButton.enable()
        }
    }
    @objc func addressDidTriggerAction(sender: FirstTextField) {
        let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! EditableAddressTableCell
        if cell.editButton.isEnabled {
            edit(sender: cell.editButton)
        }
    }
    @objc func edit(sender: Button) {
        let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! EditableAddressTableCell
        let address = cell.addressTextField.text!
        
        if addresses[sender.tag].id == 0 {
            addAddressParameters = AddAddressParameters(address: address)
            addAddressResponseController = AddAddressResponseController(viewController: viewController)
            addAddressResponseController.requestHolder = request(RequestHolder(
                endPointName: .addAddress(parameters: addAddressParameters),
                didSucceed: addAddressResponseController.didSucceed,
                didFail: addAddressResponseController.didFail,
                blocking: false
            ))
        }
        else {
            addAddressParameters = AddAddressParameters(address: address)
            responseController = ResponseController(viewController: viewController)
            responseController.requestHolder = request(RequestHolder(
                endPointName: .editAddress(
                    id: addresses[sender.tag].id,
                    parameters: addAddressParameters
                ),
                didSucceed: responseController.didSucceed,
                didFail: responseController.didFail,
                blocking: false
            ))
        }
    }
    @objc func remove(sender: Button) {
        let address = addresses[sender.tag]
        if address.id != 0 {
            responseController = ResponseController(viewController: viewController)
            responseController.requestHolder = request(RequestHolder(
                endPointName: .removeAddress(id: address.id),
                didSucceed: responseController.didSucceed,
                didFail: responseController.didFail,
                blocking: false
            ))
        }
        
        data.remove(at: sender.tag)
        tableView.deleteRows(
            at: [IndexPath(row: sender.tag, section: 0)],
            with: .automatic
        )
    }
    
    override func row(forCell cell: TableCell, atIndexPath indexPath: IndexPath) {
        super.row(forCell: cell, atIndexPath: indexPath)
        
        addresses = data as? [NewAddress]
        let castedCell = cell as! EditableAddressTableCell
        let address = addresses[indexPath.row]
        
        castedCell.addressTextField.text = address.address
        if castedCell.addressTextField.text!.isEmpty {
            castedCell.editButton.disable(animated: false)
        }
        else {
            castedCell.editButton.enable(animated: false)
        }
        
        castedCell.addressTextField.tag = indexPath.row
        castedCell.editButton.tag = indexPath.row
        castedCell.removeButton.tag = indexPath.row
        castedCell.addressTextField.addTarget(self, action: #selector(addressDidChange), for: .editingChanged)
        castedCell.addressTextField.addTarget(self, action: #selector(addressDidTriggerAction), for: .primaryActionTriggered)
        castedCell.editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        castedCell.removeButton.addTarget(self, action: #selector(remove), for: .touchUpInside)
    }
}
