import UIKit

class OrderDetailsViewController: ViewController {
    @IBOutlet weak var collectionView: CollectionView!
    
    var orderId: Int!
    var collectionController: OrderDetailsCollectionController!
    var responseController: OrderDetailsResponseController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionController = OrderDetailsCollectionController(
            viewController: self,
            collectionView: collectionView
        )
        collectionView.dataSource = collectionController
        collectionView.delegate = collectionController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            responseController = OrderDetailsResponseController(viewController: self)
            
            setLoadingState(.loading)
            responseController.requestHolder = request(RequestHolder(
                endPointName: .orderItems(id: orderId),
                didSucceed: responseController.didSucceed,
                didFail: responseController.didFail,
                blocking: true
            ))
            
            refreshControl.containerView = collectionView
            refreshControl.requestHolder = responseController.requestHolder
        }
    }
}
