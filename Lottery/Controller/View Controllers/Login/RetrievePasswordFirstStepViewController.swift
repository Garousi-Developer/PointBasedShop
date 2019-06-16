import UIKit

class RetrievePasswordFirstStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var mobileNumberTextField: FirstTextField!
    @IBOutlet weak var nextStepButton: Button!
    
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
