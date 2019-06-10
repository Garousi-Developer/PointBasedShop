import UIKit

class RetrievePasswordSecondStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var verificationCodeTextField: FirstTextField!
    @IBOutlet weak var nextStepButton: Button!
    @IBOutlet weak var cancelRetrieveCodeAndLoginButton: Button!
    
    @IBAction func verificationCodeDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func verificationCodeDidTriggerAction() {
        if nextStepButton.isEnabled {
            goNextStep()
        }
    }
    @IBAction func goNextStep() {
        navigateTo(.retrievePasswordThirdStep)
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
