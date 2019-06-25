import Foundation

class ClosestOffersResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! HomeViewController
        let offers = response as! Products
        
        castedViewController.closestOffers = offers.products
        
        castedViewController.updateHome()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
