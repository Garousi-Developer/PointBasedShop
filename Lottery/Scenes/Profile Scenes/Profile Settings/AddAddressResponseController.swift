import Foundation

class AddAddressResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedAddress = response as! NewAddress
        let castedViewController = viewController as! ProfileSettingsViewController
        let addresses = castedViewController.addressesTableController.addresses!
        var editedAddress: NewAddress!
        for address in addresses {
            if address.id == 0 {
                editedAddress = address
            }
        }
        editedAddress.id = castedAddress.id
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
