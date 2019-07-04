import UIKit

class ResponseController: SecondaryController {
    var resultLabel: Label?
    var requestHolder: RequestHolder?
    var noContentIcon: UIImage?
    var noContentText: LocalizedText?
    
    func didSucceed(response: Decodable?) {
        
    }
    func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        if let errorCode = errorCode {
            didNotConnectToInternet(errorCode: errorCode)
        }
        else if let statusCode = statusCode {
            switch statusCode {
            case 404:
//                viewController.setLoadingState(.failed(
//                    reason: .noContent,
//                    requestHolder: nil,
//                    noContentIcon: noContentIcon,
//                    noContentText: noContentText
//                    ))
                break
            case 500:
//                resultLabel?.text = texts(.internalServerError)
//                resultLabel?.fadeIn()
                break
            default:
                break
            }
        }
    }
    
    init(
        viewController: ViewController,
        resultLabel: Label? = nil,
        requestHolder: RequestHolder? = nil,
        noContentIcon: UIImage? = nil,
        noContentText: LocalizedText? = nil
    ) {
    super.init(viewController: viewController)
    
    self.resultLabel = resultLabel
    self.requestHolder = requestHolder
    self.noContentIcon = noContentIcon
    self.noContentText = noContentText
}
}
extension ResponseController {
    private func didNotConnectToInternet(errorCode: URLError.Code) {
//        switch errorCode {
//        case .notConnectedToInternet:
//            if let resultLabel = resultLabel {
//                resultLabel.text = texts(.noInternet)
//                resultLabel.fadeIn()
//            }
//            else {
//                viewController.setLoadingState(.failed(reason: .noInternet, requestHolder: requestHolder, noContentIcon: nil, noContentText: nil))
//            }
//        default:
//            break
//        }
    }
}
