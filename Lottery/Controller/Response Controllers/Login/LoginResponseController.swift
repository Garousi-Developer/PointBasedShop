import Foundation

class LoginResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! LoginViewController
        let user = response as! User
        
        UserDefaults.standard.set(user.token, forKey: "token")
//        loginViewController.loginButton.setLoadingState(.successful)
        castedViewController.navigateTo(.tabs, presenting: true)
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
//        let loginVC = viewController as! LoginVC
//        loginVC.loginButton.setLoadingState(.failed(reason: nil, requestHolder: nil, noContentIcon: nil, noContentText: nil))
//
//        guard let apiError = response as? APIError else { return }
//        guard let statusCode = statusCode else { return }
//
//        switch statusCode {
//        case 422:
//            switch apiError.reason {
//            case "notRegisterd":
//                loginVC.resultLabel.text = texts(.unregisteredMobileNumber)
//            case "notActivated":
//                loginVC.resultLabel.text = texts(.inactiveAccount)
//            case "wrongCredentials":
//                loginVC.resultLabel.text = texts(.wrongCredentials)
//            default:
//                return
//            }
//        default:
//            return
//        }
//        loginVC.resultLabel.fadeIn()
    }
}
