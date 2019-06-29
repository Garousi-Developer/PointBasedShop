import UIKit

class ProfileResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ProfileViewController
        let profile = response as! Profile
        
        castedViewController.tableController = ProfileTableController(
            viewController: viewController,
            tableView: castedViewController.tableView
        )
        castedViewController.tableView.dataSource = castedViewController.tableController
        castedViewController.tableView.delegate = castedViewController.tableController
        castedViewController.tableController.profile = profile
        castedViewController.tableView.reloadData()
        
        castedViewController.setLoadingState(.successful)
        castedViewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
