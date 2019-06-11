import UIKit

class RegisterThirdStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var firstNameTextField: FirstTextField!
    @IBOutlet weak var lastNameTextField: FirstTextField!
    @IBOutlet weak var emailTextField: FirstTextField!
    @IBOutlet weak var agreementSwitch: UISwitch!
    @IBOutlet weak var agreementLabel: Label!
    @IBOutlet weak var registerButton: Button!
    @IBOutlet weak var cancelRegisterAndLoginButton: Button!
    
    @IBAction func firstNameDidChange() {
        handleRegisterAbility()
    }
    @IBAction func lastNameDidChange() {
        handleRegisterAbility()
    }
    @IBAction func emailDidChange() {
        handleRegisterAbility()
    }
    @IBAction func emailDidTriggerAction() {
        if registerButton.isEnabled {
            register()
        }
    }
    @IBAction func agreementDidToggle() {
        handleRegisterAbility()
    }
    @IBAction func register() {
        
    }
    @IBAction func cancelRegisterAndLogin() {
        delay(durations(.interaction)) {
            self.navigateBackToRoot()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.isVerified = true
    }
}

extension RegisterThirdStepViewController {
    private func handleRegisterAbility() {
        if !firstNameTextField.text!.isEmpty && !lastNameTextField.text!.isEmpty && emailTextField.isVerified && agreementSwitch.isOn {
            registerButton.enable()
        }
        else {
            registerButton.disable()
        }
    }
}
