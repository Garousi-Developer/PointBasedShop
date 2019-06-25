import UIKit

class RegisterSecondStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var verificationCodeTextField: FirstTextField!
    @IBOutlet weak var nextStepButton: Button!
    @IBOutlet weak var resultLabel: Label!
    @IBOutlet weak var cancelRegisterAndLoginButton: Button!
    
    var registerFirstStepParameters: RegisterFirstStepParameters!
    var registerSecondStepParameters: RegisterSecondStepParameters!
    var responseController: RegisterSecondStepResponseController!
    
    @IBAction func verificationCodeDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func verificationCodeDidTriggerAction() {
        if nextStepButton.isEnabled {
            goNextStep()
        }
    }
    @IBAction func goNextStep() {
        nextStepButton.setLoadingState(.loading)
        resultLabel.fadeOut()
        
        registerSecondStepParameters = RegisterSecondStepParameters(
            mobileNumber: registerFirstStepParameters.mobileNumber,
            verificationCode: Int(verificationCodeTextField.text!)!
        )
        responseController = RegisterSecondStepResponseController(viewController: self)
        
        responseController.requestHolder = request(RequestHolder(
            endPointName: .registerSecondStep(parameters: registerSecondStepParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
        ))
    }
    @IBAction func cancelRegisterAndLogin() {
        delay(durations(.interaction)) {
            self.navigateBackToRoot()
        }
    }
}

extension RegisterSecondStepViewController {
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
