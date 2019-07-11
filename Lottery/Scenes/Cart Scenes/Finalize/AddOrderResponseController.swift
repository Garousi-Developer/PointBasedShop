import Foundation

class AddOrderResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! FinalizeViewController
        let previousViewController = castedViewController.navigationController!.viewControllers[0] as! CartViewController
        
        castedViewController.payButton.setLoadingState(.successful)
        castedViewController.addressView.fadeOut()
        
        viewController.navigateBack(animated: false)
        previousViewController.tabBarController!.selectedIndex = 3
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
