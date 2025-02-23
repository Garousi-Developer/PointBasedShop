import UIKit

class ProductViewController: ViewController {
    @IBOutlet weak var scrollView: ScrollView!
    @IBOutlet weak var collectionView: CollectionView!
    @IBOutlet weak var bottomView: View!
    @IBOutlet weak var sectionsStackView: StackView!
    @IBOutlet weak var descriptionButton: Button!
    @IBOutlet weak var productDetailsButton: Button!
    @IBOutlet weak var descriptionLabel: Label!
    @IBOutlet weak var productDetailsTableView: TableView!
    
    var productName: String!
    var productId: Int!
    var section = ProductSection.description
    var scrollController: ProductScrollController!
    var collectionController: ProductsCollectionController!
    var productDetailsTableController: ProductDetailsTableController!
    var responseController: ProductResponseController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = productName
        scrollView.delaysContentTouches = true
        
        scrollController = ProductScrollController(viewController: self, scrollView: scrollView)
        scrollView.delegate = scrollController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLoadingState(.loading)
        responseController = ProductResponseController(viewController: self)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .product(id: productId),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
        ))
        
        refreshControl.containerView = scrollView
        refreshControl.requestHolder = responseController.requestHolder
    }
    
    @IBAction func showDescription() {
        section = .description
        
        productDetailsTableView.fadeOut()
        descriptionLabel.fadeIn()
        
        UIView.animate(withDuration: durations(.textField)) {
            self.descriptionButton.backgroundColor = colors(.white)
            self.productDetailsButton.backgroundColor = colors(.darkPlaceholder)
        }
    }
    @IBAction func showProductDetails() {
        section = .productDetails
        
        descriptionLabel.fadeOut()
        productDetailsTableView.fadeIn()
        
        UIView.animate(withDuration: durations(.textField)) {
            self.productDetailsButton.backgroundColor = colors(.white)
            self.descriptionButton.backgroundColor = colors(.darkPlaceholder)
        }
    }
}

enum ProductSection {
    case description
    case productDetails
}
