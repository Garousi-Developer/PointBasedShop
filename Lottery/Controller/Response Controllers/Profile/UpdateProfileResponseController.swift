import Foundation

class UpdateProfileResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ProfileSettingsViewController
        
        castedViewController.profile.firstName = castedViewController.updateProfileParameters.firstName
        castedViewController.profile.lastName = castedViewController.updateProfileParameters.lastName
        castedViewController.profile.email = castedViewController.updateProfileParameters.email
        castedViewController.profile.mobileNumber = castedViewController.updateProfileParameters.mobileNumber
        
        castedViewController.saveChangesButton.setLoadingState(.successful)
        castedViewController.resultLabel.textColor = colors(.green)
        castedViewController.resultLabel.localizedText = texts(.yourInformationSuccessfullyUpdated)
        castedViewController.resultLabel.fadeIn()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
