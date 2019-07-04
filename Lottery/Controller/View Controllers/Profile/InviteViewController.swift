import UIKit

class InviteViewController: ViewController {
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var mobileNumberTextField: FirstTextField!
    @IBOutlet weak var inviteButton: Button!
    @IBOutlet weak var resultLabel: Label!
    
    var inviteParameters: InviteParameters!
    var responseController: ResponseController!
    
    @IBAction func mobileNumberDidChange() {
        handleInviteAbility()
    }
    @IBAction func mobileNumberDidTriggerAction() {
        if inviteButton.isEnabled {
            invite()
        }
    }
    @IBAction func invite() {
        inviteButton.setLoadingState(.loading)
        resultLabel.fadeOut()
        
        inviteParameters = InviteParameters(
            mobileNumber: mobileNumberTextField.firstCommonMobileNumber
        )
        responseController = InviteResponseController(viewController: self)
        
        responseController.requestHolder = request(RequestHolder(
            endPointName: .invite(parameters: inviteParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
        ))
    }
}

extension InviteViewController {
    private func handleInviteAbility() {
        if mobileNumberTextField.isVerified {
            inviteButton.enable()
        }
        else {
            inviteButton.disable()
        }
    }
}
