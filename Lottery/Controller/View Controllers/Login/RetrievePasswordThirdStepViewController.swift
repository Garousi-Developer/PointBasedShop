import UIKit

class RetrievePasswordThirdStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var passwordTextField: FirstTextField!
    @IBOutlet weak var passwordRepeatTextField: FirstTextField!
    @IBOutlet weak var clientErrorLabel: Label!
    @IBOutlet weak var retrievePasswordButton: Button!
    @IBOutlet weak var cancelRetrieveCodeAndLoginButton: Button!
    
    var retrievePasswordSecondStep: RetrievePasswordSecondStep!
    var retrievePasswordThirdStepParameters: RetrievePasswordThirdStepParameters!
    var responseController: RetrievePasswordThirdStepResponseController!
    
    @IBAction func passwordDidChange() {
        handleRetrievePasswordAbility()
    }
    @IBAction func passwordRepeatDidChange() {
        handleRetrievePasswordAbility()
    }
    @IBAction func passwordRepeatDidTriggerAction() {
        if retrievePasswordButton.isEnabled {
            retrievePassword()
        }
    }
    @IBAction func retrievePassword() {
        retrievePasswordButton.setLoadingState(.loading)
        
        retrievePasswordThirdStepParameters = RetrievePasswordThirdStepParameters(
            password: passwordTextField.text!,
            token: retrievePasswordSecondStep.token
        )
        responseController = RetrievePasswordThirdStepResponseController(viewController: self)
        
        responseController.requestHolder = request(RequestHolder(
            endPointName: .retrievePasswordThirdStep(parameters: retrievePasswordThirdStepParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
        ))
    }
    @IBAction func cancelRetrieveCodeAndLogin() {
        delay(durations(.interaction)) {
            self.navigateBackToRoot()
        }
    }
}

extension RetrievePasswordThirdStepViewController {
    private func handleRetrievePasswordAbility() {
        if passwordTextField.isVerified && passwordRepeatTextField.isVerified {
            if passwordRepeatTextField.text == passwordTextField.text {
                clientErrorLabel.fadeOut()
                
                retrievePasswordButton.enable()
            }
            else {
                clientErrorLabel.localizedText = texts(.unmatchedPasswords)
                clientErrorLabel.fadeIn()
                
                retrievePasswordButton.disable()
            }
        }
        else {
            retrievePasswordButton.disable()
        }
    }
}
