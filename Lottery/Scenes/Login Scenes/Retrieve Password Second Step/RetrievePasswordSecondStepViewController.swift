import UIKit

class RetrievePasswordSecondStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var verificationCodeTextField: FirstTextField!
    @IBOutlet weak var nextStepButton: Button!
    @IBOutlet weak var resultLabel: Label!
    @IBOutlet weak var cancelRetrieveCodeAndLoginButton: Button!
    
    var retrievePasswordFirstStepParameters: RetrievePasswordFirstStepParameters!
    var retrievePasswordSecondStepParameters: RetrievePasswordSecondStepParameters!
    var responseController: RetrievePasswordSecondStepResponseController!
    
    @IBAction func verificationCodeDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func verificationCodeDidTriggerAction() {
        if nextStepButton.isEnabled {
            goNextStep()
        }
    }
    @IBAction func goNextStep() {
        (navigationItem as! NavigationItem).localizedBackButtonTitle = texts(.secondStep)
        
        nextStepButton.setLoadingState(.loading)
        resultLabel.fadeOut()
        
        retrievePasswordSecondStepParameters = RetrievePasswordSecondStepParameters(
            mobileNumber: retrievePasswordFirstStepParameters.mobileNumber,
            verificationCode: verificationCodeTextField.text!
        )
        responseController = RetrievePasswordSecondStepResponseController(viewController: self)
        
        responseController.requestHolder = request(RequestHolder(
            endPointName: .retrievePasswordSecondStep(parameters: retrievePasswordSecondStepParameters),
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

extension RetrievePasswordSecondStepViewController {
    private func handleGoNextStepAbility() {
        if verificationCodeTextField.text!.count == 5 {
            verificationCodeTextField.verify()
            nextStepButton.enable()
        }
        else {
            verificationCodeTextField.showError(texts(.invalidVerificationCode))
            nextStepButton.disable()
        }
    }
}
