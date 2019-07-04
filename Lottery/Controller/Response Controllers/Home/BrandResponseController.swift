import Foundation
import Alamofire

class BrandResponseController: ResponseController {
    var staticMapParameters: StaticMapParameters!
    
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ContainerViewController
        let brandDetails = response as! BrandDetails
        castedViewController.brandDetails = brandDetails
        
        castedViewController.pictureImageView.downloadImageFrom(brandDetails.pictureURL)
        castedViewController.nameLabel.text = languageIsPersian ? brandDetails.persianTitle : brandDetails.englishTitle
        castedViewController.descriptionLabel.text = languageIsPersian ? brandDetails.persianDescription : brandDetails.englishDescription
        castedViewController.adImageView.downloadImageFrom(brandDetails.ad.pictureURL)
        
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
            center: "35.6892,51.3890",
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
