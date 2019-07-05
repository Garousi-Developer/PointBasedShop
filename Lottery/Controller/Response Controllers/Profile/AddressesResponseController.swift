import Foundation

class AddressesResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let cart = response as! Cart
        let castedViewController = viewController as! ProfileSettingsViewController
        
        castedViewController.addressesTableController.data = cart.data.addresses
        castedViewController.addressesTableView.reloadData()
        
        viewController.setLoadingState(.successful)
        viewController.refreshControl.endRefreshing()
        
        castedViewController.fillTextFields()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
