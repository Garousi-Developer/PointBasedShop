import Foundation

class ApplyFilterResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! FilterViewController
        let previousViewController = viewController.navigationController!.viewControllers[1] as! FilterResultsViewController
        let filterResults = response as! Products
        
        previousViewController.filterParameters = castedViewController.filterParameters
        
        previousViewController.collectionController = ProductsCollectionController(
            viewController: viewController,
            collectionView: previousViewController.collectionView
        )
        previousViewController.collectionController.data = filterResults.products
        previousViewController.collectionView.dataSource = previousViewController.collectionController
        previousViewController.collectionView.delegate = previousViewController.collectionController
        
        castedViewController.navigateBack()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}