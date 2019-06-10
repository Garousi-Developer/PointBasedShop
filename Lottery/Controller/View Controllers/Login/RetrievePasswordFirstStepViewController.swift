import UIKit

class RetrievePasswordFirstStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var mobileNumberTextField: FirstTextField!
    @IBOutlet weak var nextStepButton: Button!
    @IBOutlet weak var registerButton: Button!
    
    @IBAction func mobileNumberDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func mobileNumberDidTriggerAction() {
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
        
        navigateTo(.retrievePasswordSecondStep)
    }
    @IBAction func register() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: texts(.retrieveCode),
            style: .plain,
            target: nil,
            action: nil
        )
        
        navigateTo(.registerFirstStep)
    }
}

extension RetrievePasswordFirstStepViewController {
    private func handleGoNextStepAbility() {
        if mobileNumberTextField.isVerified {
            nextStepButton.enable()
        }
        else {
            nextStepButton.disable()
        }
    }
}
