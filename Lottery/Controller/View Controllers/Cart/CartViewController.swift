import UIKit

class CartViewController: ViewController {
    @IBOutlet weak var collectionView: CollectionView!
    @IBOutlet weak var addressView: View!
    @IBOutlet weak var numberOfProductsTitleLabel: Label!
    @IBOutlet weak var numberOfProductsLabel: Label!
    @IBOutlet weak var earnedPointsLabel: Label!
    @IBOutlet weak var totalPriceTitleLabel: Label!
    @IBOutlet weak var totalPriceLabel: Label!
    @IBOutlet weak var taxInclusiveLabel: Label!
    @IBOutlet weak var donateLabel: Label!
    @IBOutlet weak var donateSwitch: Switch!
    @IBOutlet weak var addressSelectionLabel: Label!
    @IBOutlet weak var payButton: Button!
    
    var cart: Cart!
    var collectionController: ProductsCollectionController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cart = Cart(
            products: [
                Product(
                    isUnlocked: true,
                    requiredPoints: 50,
                    isFavorite: false,
                    picture: #imageLiteral(resourceName: "testProduct1"),
                    name: "دوچرخه",
                    price: 6500000,
                    discountedPrice: 5200000,
                    brandLogo: #imageLiteral(resourceName: "testProductBrand1"),
                    orderCount: 2,
                    numberOfSoldProducts: 320,
                    numberOfProducts: 375
                )
            ]
        )
        
        earnedPointsLabel.text = "\(texts(.youWillEarnXPointsFromThisPurchase))"
            .replacingOccurrences(of: texts(.pointsAmount), with: "60")
        totalPriceLabel.text = "\(10400000.priceFormatted) \(texts(.currency))"
        
        collectionController = ProductsCollectionController(
            viewController: self,
            collectionView: collectionView
        )
        collectionController.index = 0
        collectionController.sharedData = [cart.products]
        collectionView.dataSource = collectionController
        collectionView.delegate = collectionController
    }
}
