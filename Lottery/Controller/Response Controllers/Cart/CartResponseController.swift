import Foundation

class CartResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! CartViewController
        let cart = response as! Products
        
        castedViewController.productsCollectionController = ProductsCollectionController(
            viewController: viewController,
            collectionView: castedViewController.productsCollectionView
        )
        castedViewController.productsCollectionController.data = cart.products
        castedViewController.productsCollectionView.dataSource = castedViewController.productsCollectionController
        castedViewController.productsCollectionView.delegate = castedViewController.productsCollectionController
        
        castedViewController.setProductsHeight()
        castedViewController.setLoadingState(.successful)
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
