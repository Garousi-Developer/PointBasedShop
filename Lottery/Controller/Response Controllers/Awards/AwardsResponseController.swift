import Foundation

class AwardsResponseController: ResponseController {
    var awards: Awards!
    
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! AwardsViewController
        awards = response as? Awards
        
        castedViewController.setLoadingState(.successful)
        castedViewController.shoppingCenterPictureImageView.downloadImageFrom(awards.pictureURL)
        castedViewController.welcomeLabel.text =
            texts(.welcomeToXShoppingCenter).replacingOccurrences(of: texts(.shoppingCenterName), with: awards.persianTitle)
        castedViewController.checkInDescriptionLabel.text =
            texts(.tapCheckInToClaimXLoyaltyPoints).replacingOccurrences(of: texts(.pointsAmount), with: String(awards.checkInPoint))
        castedViewController.claimPointsDescriptionLabel.text = texts(.takeYourTodaysInvoicesToXShoppingCenterCounter)
            .replacingOccurrences(of: texts(.shoppingCenterName), with: awards.persianTitle)
        castedViewController.adImageView.downloadImageFrom(awards.ad.pictureURL)
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
