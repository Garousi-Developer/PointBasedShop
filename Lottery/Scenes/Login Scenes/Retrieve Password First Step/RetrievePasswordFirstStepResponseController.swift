import Foundation

class RetrievePasswordFirstStepResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! RetrievePasswordFirstStepViewController
        
        castedViewController.nextStepButton.setLoadingState(.successful)
        castedViewController.navigateTo(
            .retrievePasswordSecondStep,
            transferringData: castedViewController.retrievePasswordFirstStepParameters
        )
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
        let castedViewController = viewController as! RetrievePasswordFirstStepViewController
        
//        guard let apiError = response as? APIError else { return }
        guard let statusCode = statusCode else { return }
        
        switch statusCode {
        case 404:
            castedViewController.resultLabel.localizedText = texts(.unregisteredMobileNumber)
        default:
            return
        }
        
        castedViewController.nextStepButton.setLoadingState(.successful)
        castedViewController.resultLabel.fadeIn()
    }
}
