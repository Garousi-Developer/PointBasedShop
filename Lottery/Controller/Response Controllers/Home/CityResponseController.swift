import Foundation
import Alamofire

class CityResponseController: ResponseController {
    var staticMapParameters: StaticMapParameters!
    
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ContainerViewController
        let cityDetails = response as! CityDetails
        
        castedViewController.setLoadingState(.successful)
        castedViewController.pictureImageView.downloadImageFrom(cityDetails.pictureURL)
        castedViewController.nameLabel.text = cityDetails.persianTitle
        castedViewController.descriptionLabel.text = cityDetails.persianDescription
        castedViewController.adImageView.downloadImageFrom(cityDetails.ad.pictureURL)
        
        castedViewController.topContentsCollectionController = ContainersCollectionController(
            viewController: viewController,
            collectionView: castedViewController.topContentsCollectionView
        )
        castedViewController.topContentsCollectionController.data = cityDetails.topShoppingCenters
        castedViewController.topContentsCollectionView.dataSource = castedViewController.topContentsCollectionController
        castedViewController.topContentsCollectionView.delegate = castedViewController.topContentsCollectionController
        
        castedViewController.hottestOffersCollectionController = ProductsCollectionController(
            viewController: viewController,
            collectionView: castedViewController.hottestOffersCollectionView
        )
        castedViewController.hottestOffersCollectionController.data = cityDetails.hottestOffers
        castedViewController.hottestOffersCollectionView.dataSource = castedViewController.hottestOffersCollectionController
        castedViewController.hottestOffersCollectionView.delegate = castedViewController.hottestOffersCollectionController
        
        staticMapParameters = StaticMapParameters(center: "\(cityDetails.latitude),\(cityDetails.longitude)")
        
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
