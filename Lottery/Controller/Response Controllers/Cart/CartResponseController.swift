import UIKit

class CartResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let cart = response as! Cart
        
        switch viewController {
        case is CartViewController:
            let castedViewController = viewController as! CartViewController
            
            castedViewController.productsCollectionController.data = cart.data.products
            castedViewController.setProductsHeight()
            
            if cart.data.products.isEmpty {
                castedViewController.setLoadingState(.failed(
                    reason: .noContent,
                    requestHolder: nil,
                    noContentIcon: languageIsPersian ? #imageLiteral(resourceName: "bigCart").withHorizontallyFlippedOrientation() : #imageLiteral(resourceName: "bigCart"),
                    noContentText: texts(.yourCartIsEmpty)
                ))
            }
            else {
                castedViewController.setLoadingState(.successful)
            }
        case is FinalizeViewController:
            let castedViewController = viewController as! FinalizeViewController
            
            castedViewController.numberOfProductsLabel.text = "\(cart.data.count)"
            castedViewController.earnedPointsLabel.text = languageIsPersian ?
                texts(.youWillEarnXPointsFromThisPurchase).persian
                    .replacingOccurrences(of: texts(.pointsAmount).persian, with: "\(Int(cart.data.earnedPoints).priceFormatted)") :
                texts(.youWillEarnXPointsFromThisPurchase).english
                    .replacingOccurrences(of: texts(.pointsAmount).english, with: "\(Int(cart.data.earnedPoints).priceFormatted)")
            castedViewController.totalPriceLabel.text = languageIsPersian ?
                "\(cart.data.totalPrice.priceFormatted) \(texts(.currency).persian)" :
                "\(cart.data.totalPrice.priceFormatted) \(texts(.currency).english)"
            
            castedViewController.addressesTableController = AddressesTableController(
                viewController: viewController,
                tableView: castedViewController.addressesTableView
            )
            castedViewController.addressesTableController.data = cart.data.addresses
            castedViewController.addressesTableView.dataSource = castedViewController.addressesTableController
            castedViewController.addressesTableView.delegate = castedViewController.addressesTableController
            castedViewController.setAddressesHeight(numberOfAddresses: cart.data.addresses.count)
            
            if cart.data.addresses.isEmpty {
                castedViewController.editAddressButton.setImage(#imageLiteral(resourceName: "increment"), for: .normal)
                castedViewController.editAddressButton.setLocalizedTitle(texts(.addAddress), for: .normal)
            }
            else {
                castedViewController.editAddressButton.setImage(#imageLiteral(resourceName: "editAddress"), for: .normal)
                castedViewController.editAddressButton.setLocalizedTitle(texts(.editAddress), for: .normal)
            }
            
            castedViewController.setLoadingState(.successful)
        default:
            return
        }
        
        viewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
