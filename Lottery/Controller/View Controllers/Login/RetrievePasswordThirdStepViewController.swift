import UIKit

class RetrievePasswordThirdStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var passwordTextField: FirstTextField!
    @IBOutlet weak var passwordRepeatTextField: FirstTextField!
    @IBOutlet weak var retrievePasswordButton: Button!
    @IBOutlet weak var cancelRetrieveCodeAndLoginButton: Button!
    
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
            retrievePasswordButton.enable()
        }
        else {
            retrievePasswordButton.disable()
        }
    }
}
