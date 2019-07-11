import UIKit

class FavoritesViewController: ViewController {
    @IBOutlet weak var collectionView: CollectionView!
    @IBOutlet weak var removeAllButton: Button!
    @IBOutlet weak var addAllToCartButton: Button!
    
    var collectionController: ProductsCollectionController!
    var favoritesResponseController: FavoritesResponseController!
    var removeFavoriteParameters: RemoveFavoriteParameters!
    var updateCartParameters: UpdateCartParameters!
    var responseController: ResponseController!
    var addAllToCartResponseController: AddAllToCartResponseController!
    
    @IBAction func removeAll() {
        let productIds = collectionController.products.map { (product) -> Int in
            return product.id
        }
        
        removeFavoriteParameters = RemoveFavoriteParameters(productIds: productIds)
        responseController = ResponseController(viewController: self)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .removeFavorite(parameters: removeFavoriteParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: false
        ))
        
        collectionController.data = []
        removeAllButton.fadeOut()
        addAllToCartButton.fadeOut()
    }
    @IBAction func addAllToCart() {
        let productIds = collectionController.products.map { (product) -> Int in
            return product.id
        }
        
        addAllToCartButton.setLoadingState(.loading)
        updateCartParameters = UpdateCartParameters(productIds: productIds, updateType: "increment")
        addAllToCartResponseController = AddAllToCartResponseController(viewController: self)
        addAllToCartResponseController.requestHolder = request(RequestHolder(
            endPointName: .updateCart(parameters: updateCartParameters),
            didSucceed: addAllToCartResponseController.didSucceed,
            didFail: addAllToCartResponseController.didFail,
            blocking: true
        ))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionController = ProductsCollectionController(
            viewController: self,
            collectionView: collectionView
        )
        collectionView.dataSource = collectionController
        collectionView.delegate = collectionController
        
        removeAllButton.firstInteractionAnimationType = .glow
        addAllToCartButton.firstInteractionAnimationType = .glow
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            setLoadingState(.loading)
            favoritesResponseController = FavoritesResponseController(viewController: self)
            favoritesResponseController.requestHolder = request(RequestHolder(
                endPointName: .favorites,
                didSucceed: favoritesResponseController.didSucceed,
                didFail: favoritesResponseController.didFail,
                blocking: true
            ))
            
            refreshControl.containerView = collectionView
            refreshControl.requestHolder = favoritesResponseController.requestHolder
        }
    }
}
