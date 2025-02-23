import UIKit

class LoginViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var mobileNumberTextField: FirstTextField!
    @IBOutlet weak var passwordTextField: FirstTextField!
    @IBOutlet weak var loginButton: Button!
    @IBOutlet weak var resultLabel: Label!
    @IBOutlet weak var loginWithoutRegisterButton: Button!
    @IBOutlet weak var retrievePasswordButton: Button!
    @IBOutlet weak var registerButton: Button!
    
    var loginParameters: LoginParameters!
    var responseController: LoginResponseController!
    
    @IBAction func mobileNumberDidChange() {
        handleLoginAbility()
    }
    @IBAction func passwordDidChange() {
        handleLoginAbility()
    }
    @IBAction func passwordDidTriggerAction() {
        if loginButton.isEnabled {
            login()
        }
    }
    @IBAction func login() {
        loginButton.setLoadingState(.loading)
        resultLabel.fadeOut()
        
        loginParameters = LoginParameters(
            mobileNumber: mobileNumberTextField.firstCommonMobileNumber,
            password: passwordTextField.text!
        )
        responseController = LoginResponseController(viewController: self)
        
        responseController.requestHolder = request(RequestHolder(
            endPointName: .login(parameters: loginParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
        ))
    }
    @IBAction func loginWithoutRegister() {
        UserDefaults.standard.set(true, forKey: "skipped")
        navigateTo(.tabs, presenting: true)
    }
    @IBAction func retrievePassword() {
        navigateTo(.retrievePasswordFirstStep)
    }
    @IBAction func register() {
        navigateTo(.registerFirstStep)
    }
}

extension LoginViewController {
    private func handleLoginAbility() {
        if mobileNumberTextField.isVerified && passwordTextField.isVerified {
            loginButton.enable()
        }
        else {
            loginButton.disable()
        }
    }
}
