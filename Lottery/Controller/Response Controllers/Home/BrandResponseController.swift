import Foundation
import Alamofire

class BrandResponseController: ResponseController {
    var staticMapParameters: StaticMapParameters!
    
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ContainerViewController
        let brandDetails = response as! BrandDetails
        
        castedViewController.setLoadingState(.successful)
        castedViewController.pictureImageView.downloadImageFrom(brandDetails.pictureURL)
        castedViewController.nameLabel.text = brandDetails.persianTitle
        castedViewController.descriptionLabel.text = brandDetails.persianDescription
        castedViewController.adImageView.downloadImageFrom(brandDetails.ad.pictureURL)
        
        staticMapParameters = StaticMapParameters(center: "35.6892,51.3890")
        
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
