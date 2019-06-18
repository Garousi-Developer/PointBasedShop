import UIKit

class CartViewController: ViewController {
    @IBOutlet weak var productsCollectionView: CollectionView!
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
    @IBOutlet weak var addressesTableView: TableView!
    @IBOutlet weak var payButton: Button!
    
    var addresses: [Address]!
    var productsCollectionController: ProductsCollectionController!
    var addressesTableController: AddressesTableController!
    var cartResponseController: CartResponseController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addresses = [
            Address(
                address: "کرمانشاه - شهرک پردیس - کوی ۳۰۳",
                isSelected: false
            ),
            Address(
                address: "کرمانشاه - مسکن - خیابان مطهری",
                isSelected: false
            )
        ]
        
        earnedPointsLabel.text = "\(texts(.youWillEarnXPointsFromThisPurchase))"
            .replacingOccurrences(of: texts(.pointsAmount), with: "60")
        totalPriceLabel.text = "\(10400000.priceFormatted) \(texts(.currency))"
        
        addressesTableController = AddressesTableController(
            viewController: self,
            tableView: addressesTableView
        )
        addressesTableController.data = addresses
        addressesTableView.dataSource = addressesTableController
        addressesTableView.delegate = addressesTableController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        productsCollectionController.data = cart
        setLoadingState(.loading)
        cartResponseController = CartResponseController(viewController: self)
        cartResponseController.requestHolder = request(RequestHolder(
            endPointName: .cart,
            didSucceed: cartResponseController.didSucceed,
            didFail: cartResponseController.didFail
        ))
    }
}

extension CartViewController {
    func setProductsHeight() {
        let productsLayout = productsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfProducts = CGFloat(productsCollectionView.numberOfItems(inSection: 0))
        let productsVerticalInsets = productsLayout.sectionInset.top + productsLayout.sectionInset.bottom
        
        productsCollectionView.heightConstraint.constant =
            numberOfProducts * productsCollectionController.itemHeight() +
            (numberOfProducts - 1) * productsLayout.minimumLineSpacing +
            productsVerticalInsets +
            1
        
        if numberOfProducts == 0 {
            addressView.alpha = 0
        }
        else {
            addressView.alpha = 1
        }
    }
}

var cart: [NewProduct] = []
