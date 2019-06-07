import UIKit

class RetrievePasswordFirstStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var mobileNumberTextField: FirstTextField!
    @IBOutlet weak var retrievePasswordButton: Button!
    @IBOutlet weak var registerButton: Button!
    
    @IBAction func mobileNumberDidChange() {
        handleRetrievePasswordAbility()
    }
    @IBAction func mobileNumberDidTriggerAction() {
        if retrievePasswordButton.isEnabled {
            retrievePassword()
        }
    }
    @IBAction func retrievePassword() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: texts(.firstStep),
            style: .plain,
            target: nil,
            action: nil
        )
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
    private func handleRetrievePasswordAbility() {
        if mobileNumberTextField.isVerified {
            retrievePasswordButton.enable()
        }
        else {
            retrievePasswordButton.disable()
        }
    }
}
