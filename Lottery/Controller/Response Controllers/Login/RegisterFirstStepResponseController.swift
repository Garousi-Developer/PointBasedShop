import Foundation

class RegisterFirstStepResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! RegisterFirstStepViewController
        
        castedViewController.nextStepButton.setLoadingState(.successful)
        castedViewController.navigateTo(
            .registerSecondStep,
            transferringData: castedViewController.registerFirstStepParameters
        )
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
        let castedViewController = viewController as! RegisterFirstStepViewController
        
        guard let apiError = response as? APIError else { return }
        guard let statusCode = statusCode else { return }
        
        switch statusCode {
        case 409:
            switch apiError.code {
            case 39478:
                castedViewController.resultLabel.text = texts(.alreadyRegistered)
                break
            default:
                return
            }
        default:
            return
        }
        
        castedViewController.nextStepButton.setLoadingState(.successful)
        castedViewController.resultLabel.fadeIn()
    }
}
