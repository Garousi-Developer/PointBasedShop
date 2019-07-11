import UIKit

class RetrievePasswordFirstStepViewController: ViewController {
    @IBOutlet weak var logoImageView: ImageView!
    @IBOutlet weak var mobileNumberTextField: FirstTextField!
    @IBOutlet weak var nextStepButton: Button!
    @IBOutlet weak var resultLabel: Label!
    
    var retrievePasswordFirstStepParameters: RetrievePasswordFirstStepParameters!
    var responseController: RetrievePasswordFirstStepResponseController!
    
    @IBAction func mobileNumberDidChange() {
        handleGoNextStepAbility()
    }
    @IBAction func mobileNumberDidTriggerAction() {
        if nextStepButton.isEnabled {
            goNextStep()
        }
    }
    @IBAction func goNextStep() {
        (navigationItem as! NavigationItem).localizedBackButtonTitle = texts(.firstStep)
        
        nextStepButton.setLoadingState(.loading)
        resultLabel.fadeOut()
        
        retrievePasswordFirstStepParameters = RetrievePasswordFirstStepParameters(
            mobileNumber: mobileNumberTextField.firstCommonMobileNumber
        )
        responseController = RetrievePasswordFirstStepResponseController(viewController: self)
        
        responseController.requestHolder = request(RequestHolder(
            endPointName: .retrievePasswordFirstStep(parameters: retrievePasswordFirstStepParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
        ))
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
