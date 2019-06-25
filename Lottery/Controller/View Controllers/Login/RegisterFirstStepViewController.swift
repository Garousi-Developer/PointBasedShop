import UIKit

class RegisterFirstStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var mobileNumberTextField: FirstTextField!
    @IBOutlet weak var passwordTextField: FirstTextField!
    @IBOutlet weak var passwordRepeatTextField: FirstTextField!
    @IBOutlet weak var clientErrorLabel: Label!
    @IBOutlet weak var nextStepButton: Button!
    @IBOutlet weak var resultLabel: Label!
    
    var registerFirstStepParameters: RegisterFirstStepParameters!
    var responseController: RegisterFirstStepResponseController!
    
    @IBAction func mobileNumberDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func passwordDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func passwordRepeatDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func passwordRepeatDidTriggerAction() {
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
        
        nextStepButton.setLoadingState(.loading)
        resultLabel.fadeOut()
        
        registerFirstStepParameters = RegisterFirstStepParameters(
            mobileNumber: mobileNumberTextField.firstCommonMobileNumber,
            password: passwordTextField.text!
        )
        responseController = RegisterFirstStepResponseController(viewController: self)
        
        responseController.requestHolder = request(RequestHolder(
            endPointName: .registerFirstStep(parameters: registerFirstStepParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
        ))
    }
}

extension RegisterFirstStepViewController {
    private func handleGoNextStepAbility() {
        if mobileNumberTextField.isVerified && passwordTextField.isVerified && passwordRepeatTextField.isVerified {
            if passwordRepeatTextField.text == passwordTextField.text {
                clientErrorLabel.fadeOut()
                
                nextStepButton.enable()
            }
            else {
                clientErrorLabel.text = texts(.unmatchedPasswords)
                clientErrorLabel.fadeIn()
                
                nextStepButton.disable()
            }
        }
        else {
            nextStepButton.disable()
        }
    }
}
