import Foundation

class ClosestOffersResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! HomeViewController
        guard let topStaticTableCell =
            castedViewController.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TopStaticTableCell else { return }
        let offers = response as! Products
        
        castedViewController.tableController.closestOffersCollectionController = ProductsCollectionController(
            viewController: viewController,
            collectionView: topStaticTableCell.closestOffersCollectionView
        )
        castedViewController.tableController.closestOffersCollectionController.data = offers.products
        topStaticTableCell.closestOffersCollectionView.dataSource = castedViewController.tableController.closestOffersCollectionController
        topStaticTableCell.closestOffersCollectionView.delegate = castedViewController.tableController.closestOffersCollectionController
        
        castedViewController.tableView.reloadData()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
