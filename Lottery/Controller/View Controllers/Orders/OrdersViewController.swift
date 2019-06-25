import UIKit

class OrdersViewController: ViewController {
    @IBOutlet weak var collectionView: CollectionView!
    
    var collectionController: OrdersCollectionController!
    var responseController: OrdersResponseController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionController = OrdersCollectionController(
            viewController: self,
            collectionView: collectionView
        )
        collectionView.dataSource = collectionController
        collectionView.delegate = collectionController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            responseController = OrdersResponseController(viewController: self)
            
            setLoadingState(.loading)
            responseController.requestHolder = request(RequestHolder(
                endPointName: .orders,
                didSucceed: responseController.didSucceed,
                didFail: responseController.didFail,
                blocking: true
            ))
            
            refreshControl.containerView = collectionView
            refreshControl.requestHolder = responseController.requestHolder
        }
    }
}
