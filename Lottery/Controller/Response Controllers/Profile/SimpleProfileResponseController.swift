import UIKit

class SimpleProfileResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! ProfileViewController
        let profile = response as! SimpleProfile
        
        castedViewController.simpleTableController = SimpleProfileTableController(
            viewController: viewController,
            tableView: castedViewController.tableView
        )
        castedViewController.tableView.dataSource = castedViewController.simpleTableController
        castedViewController.tableView.delegate = castedViewController.simpleTableController
        castedViewController.simpleTableController.profile = profile
        castedViewController.tableView.reloadData()
        
        castedViewController.setLoadingState(.successful)
        castedViewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}
