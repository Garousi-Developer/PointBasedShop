import Foundation

class ClaimPointsResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ClaimPointsViewController
        
        castedViewController.resultLabel.textColor = colors(.green)
        castedViewController.resultLabel.text = texts(.yourPointsSuccessfullyUpdated)
        castedViewController.resultLabel.fadeIn()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
