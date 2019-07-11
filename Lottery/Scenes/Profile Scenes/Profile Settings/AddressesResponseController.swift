import Foundation

class AddressesResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let cart = response as! Cart
        let castedViewController = viewController as! ProfileSettingsViewController
        
        castedViewController.addresses = cart.data.addresses
        castedViewController.updatePersonalInformation()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
