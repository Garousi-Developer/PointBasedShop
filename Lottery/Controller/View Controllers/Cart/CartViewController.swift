import UIKit

class CartViewController: ViewController {
    @IBOutlet weak var scrollView: ScrollView!
    @IBOutlet weak var productsCollectionView: CollectionView!
    @IBOutlet weak var finalizeButton: Button!
    
    var productsCollectionController: ProductsCollectionController!
    var cartResponseController: CartResponseController!
    
    @IBAction func finalizePurchase() {
        navigateTo(.finalize)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollectionController = ProductsCollectionController(
            viewController: self,
            collectionView: productsCollectionView
        )
        productsCollectionView.dataSource = productsCollectionController
        productsCollectionView.delegate = productsCollectionController
        
        finalizeButton.alpha = 0
        finalizeButton.firstInteractionAnimationType = .glow
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            setLoadingState(.loading)
            cartResponseController = CartResponseController(viewController: self)
            cartResponseController.requestHolder = request(RequestHolder(
                endPointName: .cart,
                didSucceed: cartResponseController.didSucceed,
                didFail: cartResponseController.didFail,
                blocking: true
            ))
            
            refreshControl.containerView = scrollView
            refreshControl.requestHolder = cartResponseController.requestHolder
        }
    }
}

extension CartViewController {
    func setProductsHeight(animated: Bool = false) {
        let productsLayout = productsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfProducts = CGFloat(productsCollectionView.numberOfItems(inSection: 0))
        let productsVerticalInsets = productsLayout.sectionInset.top + productsLayout.sectionInset.bottom
        
        productsCollectionView.heightConstraint.constant =
            numberOfProducts * productsCollectionController.itemHeight() +
            (numberOfProducts - 1) * productsLayout.minimumLineSpacing +
            productsVerticalInsets +
            1
        if animated {
            UIView.animate(withDuration: durations(.textField)) {
                self.view.layoutIfNeeded()
            }
        }
        
        if numberOfProducts == 0 {
            finalizeButton.alpha = 0
            finalizeButton.isHidden = true
        }
        else {
            finalizeButton.alpha = 1
            finalizeButton.isHidden = false
        }
    }
}
