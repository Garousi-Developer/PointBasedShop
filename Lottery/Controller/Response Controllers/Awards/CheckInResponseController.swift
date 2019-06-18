import Foundation

class CheckInResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! AwardsViewController
        
        castedViewController.resultLabel.textColor = colors(.green)
        castedViewController.resultLabel.text = texts(.yourPointsSuccessfullyUpdated)
        castedViewController.checkInButton.fadeOut()
        castedViewController.resultLabel.fadeIn()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
        let castedViewController = viewController as! AwardsViewController
        
//        guard let apiError = response as? APIError else { return }
        guard let statusCode = statusCode else { return }
        
        switch statusCode {
        case 409:
            castedViewController.resultLabel.textColor = colors(.red)
            castedViewController.resultLabel.text = texts(.youEarnedPointsFromThisShoppingCenterForToday)
        default:
            return
        }
        
        castedViewController.checkInButton.fadeOut()
        castedViewController.resultLabel.fadeIn()
    }
}
