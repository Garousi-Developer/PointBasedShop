import Foundation

class RegisterSecondStepResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! RegisterSecondStepViewController
        
        castedViewController.nextStepButton.setLoadingState(.successful)
        castedViewController.navigateTo(
            .registerThirdStep,
            transferringData: castedViewController.registerFirstStepParameters
        )
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
        let castedViewController = viewController as! RegisterSecondStepViewController
        castedViewController.nextStepButton.setLoadingState(.successful)
        
        guard let apiError = response as? APIError else { return }
        guard let statusCode = statusCode else { return }
        
        switch statusCode {
        case 422:
            switch apiError.code {
            case 462543:
                castedViewController.resultLabel.text = texts(.wrongVerificationCode)
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
