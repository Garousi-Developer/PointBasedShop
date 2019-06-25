import UIKit

class AddAllToCartResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! FavoritesViewController
        
        castedViewController.addAllToCartButton.setLoadingState(.successful)
        castedViewController.tabBarController!.selectedIndex = 1
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
