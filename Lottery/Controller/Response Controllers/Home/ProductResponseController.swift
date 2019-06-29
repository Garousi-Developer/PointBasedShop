import UIKit

class ProductResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ProductViewController
        let productDetailses = response as! ProductDetailses
        
        castedViewController.collectionController = ProductsCollectionController(
            viewController: viewController,
            collectionView: castedViewController.collectionView
        )
        castedViewController.collectionController.data = [productDetailses.productDetails.product]
        castedViewController.collectionView.dataSource = castedViewController.collectionController
        castedViewController.collectionView.delegate = castedViewController.collectionController
        
        castedViewController.descriptionLabel.text = languageIsPersian ?
            productDetailses.productDetails.product.persianDescription :
            productDetailses.productDetails.product.englishDescription
        
        castedViewController.productDetailsTableController = ProductDetailsTableController(
            viewController: viewController,
            tableView: castedViewController.productDetailsTableView
        )
        castedViewController.productDetailsTableController.data = productDetailses.productDetails.specs
        castedViewController.productDetailsTableView.dataSource = castedViewController.productDetailsTableController
        castedViewController.productDetailsTableView.delegate = castedViewController.productDetailsTableController
        
        let descriptionHeight = castedViewController.descriptionLabel.firstTextHeight
        let specsHeight =
            CGFloat(productDetailses.productDetails.specs.count) *
            (fonts(.semiLarge).firstLineHeight + scale * 2 * 9)
        if specsHeight > descriptionHeight {
            NSLayoutConstraint.deactivate([castedViewController.descriptionLabel.bottomConstraint])
            castedViewController.productDetailsTableView.heightConstraint.constant = specsHeight
        }
        else {
            NSLayoutConstraint.deactivate([castedViewController.productDetailsTableView.heightConstraint])
        }
        
        castedViewController.setLoadingState(.successful)
        castedViewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
