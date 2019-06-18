import UIKit

class FilterResultsViewController: ViewController {
    @IBOutlet weak var searchBar: SearchBar!
    @IBOutlet weak var collectionView: CollectionView!
    
    var filtersButton: Button!
    var selectedCategory: NewCategory!
    var collectionController: ProductsCollectionController!
    var filterParameters: FilterParameters!
    var responseController: FilterResultsResponseController!
    
    @objc func showFilters() {
        navigateTo(.filter, transferringData: filterParameters)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = selectedCategory.persianTitle
        setupFilterButton()
        
        searchBar.delegate = self
        
        filterParameters = FilterParameters(
            categories: [selectedCategory.id],
            cities: [],
            searchedPhrase: ""
        )
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        collectionView.reloadData()
        setLoadingState(.loading)
        responseController = FilterResultsResponseController(viewController: self)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .filter(parameters: filterParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail
        ))
    }
}
extension FilterResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterParameters = FilterParameters(
            categories: filterParameters.categories,
            cities: filterParameters.cities,
            searchedPhrase: searchBar.text!
        )
        
        setLoadingState(.loading)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .filter(parameters: filterParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail
        ))
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
