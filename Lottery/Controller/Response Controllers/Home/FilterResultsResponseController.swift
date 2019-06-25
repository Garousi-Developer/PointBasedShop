import Foundation

class FilterResultsResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! FilterResultsViewController
        let filterResults = response as! Products
        
        castedViewController.collectionController = ProductsCollectionController(
            viewController: viewController,
            collectionView: castedViewController.collectionView
        )
        castedViewController.collectionController.data = filterResults.products
        castedViewController.collectionView.dataSource = castedViewController.collectionController
        castedViewController.collectionView.delegate = castedViewController.collectionController
        
        castedViewController.setLoadingState(.successful)
        castedViewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
