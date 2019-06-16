import UIKit

class FilterResultsViewController: ViewController {
    @IBOutlet weak var searchBar: SearchBar!
    @IBOutlet weak var collectionView: CollectionView!
    
    var filtersButton: Button!
    var filterResults: FilterResults!
    var collectionController: ProductsCollectionController!
    
    @objc func showFilters() {
//        delay(durations(.interaction)) {
//            self.navigateTo(.filter)
//        }
        navigateTo(.filter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = filterResults.title
        setupFilterButton()
        
        collectionController = ProductsCollectionController(
            viewController: self,
            collectionView: collectionView
        )
        collectionController.data = filterResults.results
        collectionView.dataSource = collectionController
        collectionView.delegate = collectionController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
}

extension FilterResultsViewController {
    private func setupFilterButton() {
        filtersButton = Button(type: .custom)
        filtersButton.frame.size.width = 36
        filtersButton.frame.size.height = 36
        filtersButton.setCornerRadius(.half)
        filtersButton.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filtersButton.firstInteractionAnimationType = InteractionAnimation.glow
        filtersButton.addTarget(self, action: #selector(showFilters), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: filtersButton)]
    }
}
