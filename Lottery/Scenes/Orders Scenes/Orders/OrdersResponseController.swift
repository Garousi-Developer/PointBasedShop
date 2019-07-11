import UIKit

class OrdersResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! OrdersViewController
        let orders = response as! Order
        
        castedViewController.collectionController.data = orders.data
        if orders.data.isEmpty {
            castedViewController.setLoadingState(.failed(
                reason: .noContent,
                requestHolder: nil,
                noContentIcon: languageIsPersian ? #imageLiteral(resourceName: "bigOrders").withHorizontallyFlippedOrientation() : #imageLiteral(resourceName: "bigOrders"),
                noContentText: texts(.youHaveNoOrdersYet),
                buttons: false
            ))
        }
        else {
            castedViewController.setLoadingState(.successful)
        }
        
        castedViewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
