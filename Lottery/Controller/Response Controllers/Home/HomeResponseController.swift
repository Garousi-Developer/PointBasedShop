import Foundation

class HomeResponseController: ResponseController {
    var closestOffersParameters: ClosestOffersParameters!
    var closestOffersResponseController: ClosestOffersResponseController!
    
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! HomeViewController
        let home = response as! Home
        
        castedViewController.setLoadingState(.successful)
        castedViewController.tableController.data = [home]
        
        closestOffersParameters = ClosestOffersParameters(latitude: "35.6892", longitude: "51.3890")
        
        closestOffersResponseController = ClosestOffersResponseController(viewController: viewController)
        closestOffersResponseController.requestHolder = request(RequestHolder(
            endPointName: .closestOffers(parameters: closestOffersParameters),
            didSucceed: closestOffersResponseController.didSucceed,
            didFail: closestOffersResponseController.didFail
        ))
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
