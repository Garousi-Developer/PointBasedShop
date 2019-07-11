import Foundation

class AwardsResponseController: ResponseController {
    var awards: Awards!
    
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! AwardsViewController
        awards = response as? Awards
        
        castedViewController.shoppingCenterPictureImageView.downloadImageFrom(awards.pictureURL)
        castedViewController.welcomeLabel.text = languageIsPersian ?
            texts(.welcomeToXShoppingCenter).persian
                .replacingOccurrences(of: texts(.shoppingCenterName).persian, with: awards.persianTitle) :
            texts(.welcomeToXShoppingCenter).english
                .replacingOccurrences(of: texts(.shoppingCenterName).english, with: awards.englishTitle)
        castedViewController.checkInDescriptionLabel.text = languageIsPersian ?
            texts(.tapCheckInToClaimXLoyaltyPoints).persian
                .replacingOccurrences(of: texts(.pointsAmount).persian, with: String(awards.checkInPoint)) :
            texts(.tapCheckInToClaimXLoyaltyPoints).english
                .replacingOccurrences(of: texts(.pointsAmount).english, with: String(awards.checkInPoint))
        castedViewController.claimPointsDescriptionLabel.text = languageIsPersian ?
            texts(.takeYourTodaysInvoicesToXShoppingCenterCounter).persian
                .replacingOccurrences(of: texts(.shoppingCenterName).persian, with: awards.persianTitle) :
            texts(.takeYourTodaysInvoicesToXShoppingCenterCounter).english
                .replacingOccurrences(of: texts(.shoppingCenterName).english, with: awards.englishTitle)
        castedViewController.adImageView.downloadImageFrom(awards.ad.pictureURL)
        
        castedViewController.setLoadingState(.successful)
        castedViewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
        
        let castedViewController = viewController as! AwardsViewController
        
        //        guard let apiError = response as? APIError else { return }
        guard let statusCode = statusCode else { return }
        
        switch statusCode {
        case 404:
            castedViewController.setLoadingState(.failed(
                reason: .noContent,
                requestHolder: nil,
                noContentIcon: #imageLiteral(resourceName: "bigAwards"),
                noContentText: texts(.noShoppingCenterFound),
                buttons: false
            ))
        default:
            return
        }
    }
}
