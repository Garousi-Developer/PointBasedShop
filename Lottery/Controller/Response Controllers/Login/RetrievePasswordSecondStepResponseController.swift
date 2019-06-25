import Foundation

class RetrievePasswordSecondStepResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! RetrievePasswordSecondStepViewController
        let retrievePasswordSecondStep = response as! RetrievePasswordSecondStep
        
        castedViewController.nextStepButton.setLoadingState(.successful)
        castedViewController.navigateTo(
            .retrievePasswordThirdStep,
            transferringData: retrievePasswordSecondStep
        )
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
        let castedViewController = viewController as! RetrievePasswordSecondStepViewController
        
//        guard let apiError = response as? APIError else { return }
        guard let statusCode = statusCode else { return }
        
        switch statusCode {
        case 400:
            castedViewController.resultLabel.text = texts(.wrongVerificationCode)
        default:
            return
        }
        
        castedViewController.nextStepButton.setLoadingState(.successful)
        castedViewController.resultLabel.fadeIn()
    }
}
