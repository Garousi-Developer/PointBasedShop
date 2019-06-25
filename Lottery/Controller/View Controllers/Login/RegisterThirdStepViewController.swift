import UIKit

class RegisterThirdStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var firstNameTextField: FirstTextField!
    @IBOutlet weak var lastNameTextField: FirstTextField!
    @IBOutlet weak var emailTextField: FirstTextField!
    @IBOutlet weak var agreementSwitch: Switch!
    @IBOutlet weak var agreementLabel: Label!
    @IBOutlet weak var registerButton: Button!
    @IBOutlet weak var cancelRegisterAndLoginButton: Button!
    
    var registerFirstStepParameters: RegisterFirstStepParameters!
    var registerThirdStepParameters: RegisterThirdStepParameters!
    var responseController: RegisterThirdStepResponseController!
    
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
        registerButton.setLoadingState(.loading)
        
        registerThirdStepParameters = RegisterThirdStepParameters(
            mobileNumber: registerFirstStepParameters.mobileNumber,
            password: registerFirstStepParameters.password,
            firstName: firstNameTextField.text!,
            lastName: lastNameTextField.text!,
            email: emailTextField.text!
        )
        responseController = RegisterThirdStepResponseController(viewController: self)
        
        responseController.requestHolder = request(RequestHolder(
            endPointName: .registerThirdStep(parameters: registerThirdStepParameters),
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
