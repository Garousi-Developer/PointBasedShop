import Foundation

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
        
        castedViewController.descriptionLabel.text = productDetailses.productDetails.product.persianDescription
        
        castedViewController.productDetailsTableController = ProductDetailsTableController(
            viewController: viewController,
            tableView: castedViewController.productDetailsTableView
        )
        castedViewController.productDetailsTableController.data = productDetailses.productDetails.specs
        castedViewController.productDetailsTableView.dataSource = castedViewController.productDetailsTableController
        castedViewController.productDetailsTableView.delegate = castedViewController.productDetailsTableController
        
        castedViewController.setLoadingState(.successful)
        castedViewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
