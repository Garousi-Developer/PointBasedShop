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
        
        navigationItem.title = languageIsPersian ? selectedCategory.persianTitle : selectedCategory.englishTitle
        setupFilterButton()
        
        searchBar.delegate = self
        
        filterParameters = FilterParameters(
            searchedPhrase: "",
            categories: [selectedCategory.id],
            cities: [],
            lockState: "unlock"
        )
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLoadingState(.loading)
        responseController = FilterResultsResponseController(viewController: self)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .filter(parameters: filterParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
        ))
        
        refreshControl.containerView = collectionView
        refreshControl.requestHolder = responseController.requestHolder
    }
}
extension FilterResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterParameters = FilterParameters(
            searchedPhrase: searchBar.text!,
            categories: filterParameters.categories,
            cities: filterParameters.cities,
            lockState: "unlock"
        )
        
        setLoadingState(.loading)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .filter(parameters: filterParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
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
