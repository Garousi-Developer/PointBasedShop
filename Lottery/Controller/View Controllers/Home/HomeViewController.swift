import UIKit

class HomeViewController: ViewController {
    @IBOutlet weak var tableView: TableView!
    
    var home: Home!
    var closestOffers: [NewProduct]!
    var tableController: HomeTableController!
    var responseController: HomeResponseController!
    var closestOffersParameters: ClosestOffersParameters!
    var closestOffersResponseController: ClosestOffersResponseController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableController = HomeTableController(
            viewController: self,
            tableView: tableView
        )
        tableView.dataSource = tableController
        tableView.delegate = tableController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLoadingState(.loading)
        tableController?.tableView.contentOffset.y = 0
        responseController = HomeResponseController(viewController: self)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .home,
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: false
        ))
        
        closestOffersParameters = ClosestOffersParameters(latitude: "35.6892", longitude: "51.3890")
        closestOffersResponseController = ClosestOffersResponseController(viewController: self)
        closestOffersResponseController.requestHolder = request(RequestHolder(
            endPointName: .closestOffers(parameters: closestOffersParameters),
            didSucceed: closestOffersResponseController.didSucceed,
            didFail: closestOffersResponseController.didFail,
            blocking: false
        ))
        
        refreshControl.containerView = tableView
        refreshControl.requestHolders = [responseController.requestHolder!, closestOffersResponseController.requestHolder!]
    }
}

extension HomeViewController {
    func updateHome() {
        if home != nil && closestOffers != nil {
            tableController.closestOffers = closestOffers
            tableController.data = [home!]
            
            setLoadingState(.successful)
            refreshControl.endRefreshing()
            
            home = nil
            closestOffers = nil
        }
    }
}
