import UIKit

class RegisterFirstStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var mobileNumberTextField: FirstTextField!
    @IBOutlet weak var passwordTextField: FirstTextField!
    @IBOutlet weak var nextStepButton: Button!
    @IBOutlet weak var retrievePasswordButton: Button!
    
    @IBAction func mobileNumberDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func passwordDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func passwordDidTriggerAction() {
        if nextStepButton.isEnabled {
            goNextStep()
        }
    }
    @IBAction func goNextStep() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: texts(.firstStep),
            style: .plain,
            target: nil,
            action: nil
        )
        
        navigateTo(.registerSecondStep)
    }
    @IBAction func retrievePassword() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: texts(.register),
            style: .plain,
            target: nil,
            action: nil
        )
        
        navigateTo(.retrievePasswordFirstStep)
    }
}

extension RegisterFirstStepViewController {
    private func handleGoNextStepAbility() {
        if mobileNumberTextField.isVerified && passwordTextField.isVerified {
            nextStepButton.enable()
        }
        else {
            nextStepButton.disable()
        }
    }
}
