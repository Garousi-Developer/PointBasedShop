import Foundation

class ClaimPointsResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ClaimPointsViewController
        
        castedViewController.submitButton.setLoadingState(.successful)
        castedViewController.resultLabel.textColor = colors(.green)
        castedViewController.resultLabel.text = texts(.yourPointsSuccessfullyUpdated)
        castedViewController.resultLabel.fadeIn()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
        let castedViewController = viewController as! ClaimPointsViewController
        
        //        guard let apiError = response as? APIError else { return }
        guard let statusCode = statusCode else { return }
        
        switch statusCode {
        case 401:
            castedViewController.resultLabel.textColor = colors(.red)
            castedViewController.resultLabel.text = texts(.wrongToken)
        case 404:
            castedViewController.resultLabel.textColor = colors(.red)
            castedViewController.resultLabel.text = texts(.wrongEmployeeId)
        default:
            return
        }
        
        castedViewController.submitButton.setLoadingState(.successful)
        castedViewController.resultLabel.fadeIn()
    }
}
