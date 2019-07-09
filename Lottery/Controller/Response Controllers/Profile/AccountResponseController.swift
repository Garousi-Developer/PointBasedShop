import Foundation

class AccountResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let profile = response as! Profile
        let castedViewController = viewController as! ProfileSettingsViewController
        
        castedViewController.profile = profile
        castedViewController.updatePersonalInformation()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
