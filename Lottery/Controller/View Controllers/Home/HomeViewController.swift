import UIKit

class HomeViewController: ViewController {
    @IBOutlet weak var tableView: TableView!
    
    var tableController: HomeTableController!
    var responseController: HomeResponseController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableController = HomeTableController(viewController: self, tableView: tableView)
        tableView.dataSource = tableController
        tableView.delegate = tableController
        
        setLoadingState(.loading)
        responseController = HomeResponseController(viewController: self)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .home,
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail
        ))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let homeTopStaticCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TopStaticTableCell
//        homeTopStaticCell?.closestOffersCollectionView.reloadData()
    }
}
