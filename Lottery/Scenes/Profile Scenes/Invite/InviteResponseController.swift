import UIKit

class InviteResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! InviteViewController
        
        castedViewController.inviteButton.setLoadingState(.successful)
        
        castedViewController.resultLabel.localizedText = texts(.yourInvitationSentSuccessfully)
        castedViewController.resultLabel.textColor = colors(.green)
        castedViewController.resultLabel.fadeIn()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
        let castedViewController = viewController as! InviteViewController
        
//        guard let apiError = response as? APIError else { return }
        guard let statusCode = statusCode else { return }
        
        switch statusCode {
        case 410:
            castedViewController.resultLabel.localizedText = texts(.thisNumberHasAlreadyBeenInvited)
        case 422:
            castedViewController.resultLabel.localizedText = texts(.thisNumberHasAlreadyRegistered)
        default:
            return
        }
        
        castedViewController.inviteButton.setLoadingState(.successful)
        castedViewController.resultLabel.textColor = colors(.red)
        castedViewController.resultLabel.fadeIn()
    }
}
