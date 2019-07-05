import UIKit

class UpdateNumberResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ProfileSettingsViewController
        
        castedViewController.saveChangesButton.topConstraint.constant = scale * 42
        castedViewController.verificationCodeTextField.fadeIn()
        castedViewController.verificationCodeTextField.becomeFirstResponder()
        UIView.animate(withDuration: durations(.textField)) {
            castedViewController.view.layoutIfNeeded()
        }
        
        castedViewController.verifyButton.setLoadingState(.successful)
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
