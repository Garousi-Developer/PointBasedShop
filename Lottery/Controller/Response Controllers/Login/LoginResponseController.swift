import Foundation

class LoginResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! LoginViewController
        let user = response as! User
        
        UserDefaults.standard.set(user.token, forKey: "token")
        castedViewController.loginButton.setLoadingState(.successful)
        castedViewController.navigateTo(.tabs, presenting: true)
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
        let castedViewController = viewController as! LoginViewController
        
        guard let apiError = response as? APIError else { return }
        guard let statusCode = statusCode else { return }
        
        switch statusCode {
        case 401:
            switch apiError.code {
            case 3683:
                castedViewController.resultLabel.localizedText = texts(.unregisteredMobileNumber)
            case 22843:
                castedViewController.resultLabel.localizedText = texts(.inactiveAccount)
            case 9674:
                castedViewController.resultLabel.localizedText = texts(.wrongCredentials)
            default:
                return
            }
        default:
            return
        }
        
        castedViewController.loginButton.setLoadingState(.successful)
        castedViewController.resultLabel.fadeIn()
    }
}
