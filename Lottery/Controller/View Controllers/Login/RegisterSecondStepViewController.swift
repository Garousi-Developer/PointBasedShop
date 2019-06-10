import UIKit

class RegisterSecondStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var verificationCodeTextField: FirstTextField!
    @IBOutlet weak var nextStepButton: Button!
    @IBOutlet weak var cancelRegisterAndLoginButton: Button!
    
    @IBAction func verificationCodeDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func verificationCodeDidTriggerAction() {
        if nextStepButton.isEnabled {
            goNextStep()
        }
    }
    @IBAction func goNextStep() {
        navigateTo(.registerThirdStep)
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
