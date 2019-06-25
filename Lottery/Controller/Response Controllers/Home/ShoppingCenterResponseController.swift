import Foundation
import Alamofire

class ShoppingCenterResponseController: ResponseController {
    var staticMapParameters: StaticMapParameters!
    
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ContainerViewController
        let shoppingCenterDetails = response as! ShoppingCenterDetails
        
        castedViewController.pictureImageView.downloadImageFrom(shoppingCenterDetails.pictureURL)
        castedViewController.nameLabel.text = shoppingCenterDetails.persianTitle
        castedViewController.containerNameLabel.text = " \(shoppingCenterDetails.persianCityTitle)"
        castedViewController.descriptionLabel.text = shoppingCenterDetails.persianDescription
        castedViewController.adImageView.downloadImageFrom(shoppingCenterDetails.ad.pictureURL)
        
        castedViewController.topContentsCollectionController = ContainersCollectionController(
            viewController: viewController,
            collectionView: castedViewController.topContentsCollectionView
        )
        castedViewController.topContentsCollectionController.data = shoppingCenterDetails.topBrands
        castedViewController.topContentsCollectionView.dataSource = castedViewController.topContentsCollectionController
        castedViewController.topContentsCollectionView.delegate = castedViewController.topContentsCollectionController
        
        castedViewController.hottestOffersCollectionController = ProductsCollectionController(
            viewController: viewController,
            collectionView: castedViewController.hottestOffersCollectionView
        )
        castedViewController.hottestOffersCollectionController.data = shoppingCenterDetails.hottestOffers
        castedViewController.hottestOffersCollectionView.dataSource = castedViewController.hottestOffersCollectionController
        castedViewController.hottestOffersCollectionView.delegate = castedViewController.hottestOffersCollectionController
        
        castedViewController.setLoadingState(.successful)
        castedViewController.refreshControl.endRefreshing()
        
        staticMapParameters = StaticMapParameters(center: "\(shoppingCenterDetails.latitude),\(shoppingCenterDetails.longitude)")
        
        let endPoint = endPoints(.staticMap(parameters: staticMapParameters))
        let url = request(
            endPoint.url,
            method: endPoint.method,
            parameters: endPoint.parameters,
            encoding: endPoint.encoding,
            headers: endPoint.headers
        ).request!.url!
        castedViewController.mapImageView.downloadImageFrom(url.absoluteString)
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
