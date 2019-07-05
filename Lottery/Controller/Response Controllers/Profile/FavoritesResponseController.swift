import UIKit

class FavoritesResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! FavoritesViewController
        let favorites = response as! Favorites
        let numberOfFavorites = CGFloat(favorites.data.count)
        
        castedViewController.collectionController.data = favorites.data
        if numberOfFavorites == 0 {
            castedViewController.removeAllButton.alpha = 0
            castedViewController.addAllToCartButton.alpha = 0
        }
        else {
            castedViewController.removeAllButton.alpha = 1
            castedViewController.addAllToCartButton.alpha = 1
        }
        
        if favorites.data.isEmpty {
            castedViewController.setLoadingState(.failed(
                reason: .noContent,
                requestHolder: nil,
                noContentIcon: #imageLiteral(resourceName: "bigFavorites"),
                noContentText: texts(.noItemHasBeenAddedToFavoritesYet),
                buttons: false
            ))
        }
        else {
            castedViewController.setLoadingState(.successful)
        }
        
        castedViewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
