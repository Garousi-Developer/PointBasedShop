import Foundation

class AwardsResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! AwardsViewController
        let awards = response as! Awards
        
        castedViewController.setLoadingState(.successful)
        castedViewController.shoppingCenterPictureImageView.downloadImageFrom(awards.pictureURL)
        castedViewController.welcomeLabel.text =
            texts(.welcomeToXShoppingCenter).replacingOccurrences(of: texts(.shoppingCenterName), with: awards.persianTitle)
        castedViewController.checkInDescriptionLabel.text =
            texts(.tapCheckInToClaimXLoyaltyPoints).replacingOccurrences(of: texts(.pointsAmount), with: String(awards.checkInPoint))
        castedViewController.claimPointsDescriptionLabel.text = texts(.takeYourTodaysInvoicesToXShoppingCenterCounter)
            .replacingOccurrences(of: texts(.shoppingCenterName), with: awards.persianTitle)
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
