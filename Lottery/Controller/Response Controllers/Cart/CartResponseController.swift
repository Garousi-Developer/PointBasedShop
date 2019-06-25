import Foundation

class CartResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let cart = response as! Cart
        
        switch viewController {
        case is CartViewController:
            let castedViewController = viewController as! CartViewController
            
            castedViewController.productsCollectionController.data = cart.data.products
            castedViewController.setProductsHeight()
        case is FinalizeViewController:
            let castedViewController = viewController as! FinalizeViewController
            
            castedViewController.numberOfProductsLabel.text = "\(cart.data.count)"
            castedViewController.earnedPointsLabel.text = texts(.youWillEarnXPointsFromThisPurchase)
                .replacingOccurrences(of: texts(.pointsAmount), with: "\(Int(cart.data.earnedPoints).priceFormatted)")
            castedViewController.totalPriceLabel.text = "\(cart.data.totalPrice.priceFormatted) \(texts(.currency))"
            
            castedViewController.addressesTableController = AddressesTableController(
                viewController: viewController,
                tableView: castedViewController.addressesTableView
            )
            castedViewController.addressesTableController.data = cart.data.addresses
            castedViewController.addressesTableView.dataSource = castedViewController.addressesTableController
            castedViewController.addressesTableView.delegate = castedViewController.addressesTableController
            castedViewController.setAddressesHeight(numberOfAddresses: cart.data.addresses.count)
        default:
            return
        }
        
        viewController.setLoadingState(.successful)
        viewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
