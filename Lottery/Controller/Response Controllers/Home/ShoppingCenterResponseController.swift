import Foundation
import Alamofire

class ShoppingCenterResponseController: ResponseController {
    var staticMapParameters: StaticMapParameters!
    
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ContainerViewController
        let shoppingCenterDetails = response as! ShoppingCenterDetails
        castedViewController.shoppingCenterDetails = shoppingCenterDetails
        
        castedViewController.pictureImageView.downloadImageFrom(shoppingCenterDetails.pictureURL)
        castedViewController.nameLabel.text = languageIsPersian ? shoppingCenterDetails.persianTitle : shoppingCenterDetails.englishTitle
        castedViewController.containerNameLabel.text = languageIsPersian ?
            " \(shoppingCenterDetails.persianCityTitle)" :
            " \(shoppingCenterDetails.englishCityTitle)"
        castedViewController.descriptionLabel.text = languageIsPersian ?
            shoppingCenterDetails.persianDescription :
            shoppingCenterDetails.englishDescription
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
        
        if shoppingCenterDetails.hottestOffers.isEmpty && castedViewController.hottestOffersLabel != nil {
            castedViewController.hottestOffersLabel.removeFromSuperview()
            castedViewController.moreButton.removeFromSuperview()
            castedViewController.hottestOffersCollectionView.removeFromSuperview()
            
            castedViewController.adImageView.snp.makeConstraints { (make) in
                make.top.equalTo(castedViewController.mapImageView.snp.bottom).offset(scale * 12)
            }
        }
        
        castedViewController.descriptionLabel.numberOfLines = min(castedViewController.descriptionLabel.firstRealNumberOfLines, 5)
        castedViewController.initialDescriptionHeight = castedViewController.descriptionLabel.firstTextHeight
        castedViewController.descriptionLabel.heightConstraint.constant = castedViewController.initialDescriptionHeight
        castedViewController.descriptionLabel.numberOfLines = 0
        castedViewController.finalDescriptionHeight = castedViewController.descriptionLabel.firstTextHeight
        if castedViewController.finalDescriptionHeight == castedViewController.initialDescriptionHeight {
            castedViewController.viewMoreButton.isHidden = true
            castedViewController.viewMoreButton.heightConstraint.constant = 0
        }
        else {
            castedViewController.viewMoreButton.isHidden = false
            castedViewController.viewMoreButton.heightConstraint.constant = scale * 35
        }
        
        castedViewController.setLoadingState(.successful)
        castedViewController.refreshControl.endRefreshing()
        
        staticMapParameters = StaticMapParameters(
            center: "\(shoppingCenterDetails.latitude),\(shoppingCenterDetails.longitude)",
            zoom: 15,
            markers: nil
        )
        
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
