import UIKit

class ProductViewController: ViewController {
    @IBOutlet weak var collectionView: CollectionView!
    
    var collectionController: ProductsCollectionController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionController = ProductsCollectionController(
            viewController: self,
            collectionView: collectionView
        )
        collectionController.data = []
        collectionView.dataSource = collectionController
        collectionView.delegate = collectionController
    }
}
