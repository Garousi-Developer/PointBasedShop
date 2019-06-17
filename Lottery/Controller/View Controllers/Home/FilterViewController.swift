import UIKit

class FilterViewController: ViewController {
    @IBOutlet weak var categoriesLabel: Label!
    @IBOutlet weak var allCategoriesSwitch: Switch!
    @IBOutlet weak var categoriesCollectionView: CollectionView!
    @IBOutlet weak var citiesLabel: Label!
    @IBOutlet weak var allCitiesSwitch: Switch!
    @IBOutlet weak var citiesCollectionView: CollectionView!
    @IBOutlet weak var unlockedLabel: Label!
    @IBOutlet weak var unlockedSwitch: Switch!
    @IBOutlet weak var lockedLabel: Label!
    @IBOutlet weak var lockedSwitch: Switch!
    @IBOutlet weak var allLabel: Label!
    @IBOutlet weak var allSwitch: Switch!
    @IBOutlet weak var filterButton: Button!
    
    var filterScopes: FilterScopes!
    var filterScopesResponseController: FilterScopesResponseController!
    var filterParameters: FilterParameters!
    var applyFilterResponseController: ApplyFilterResponseController!
    
    var categoriesCollectionController: SimpleCategoriesCollectionController!
    var citiesCollectionController: SimpleCitiesCollectionController!
    
    @IBAction func allCategoriesDidToggle() {
        if allCategoriesSwitch.isOn {
            for category in categoriesCollectionController.categories {
                category.isSelected = true
            }
            for item in 0..<categoriesCollectionView.numberOfItems(inSection: 0) {
                let simpleCategoryCollectionCell =
                    categoriesCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as! SimpleCategoryCollectionCell
                simpleCategoryCollectionCell.selectedSwitch.setOn(true, animated: true)
            }
        }
        else {
            for category in categoriesCollectionController.categories {
                category.isSelected = false
            }
            for item in 0..<categoriesCollectionView.numberOfItems(inSection: 0) {
                let simpleCategoryCollectionCell =
                    categoriesCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as! SimpleCategoryCollectionCell
                simpleCategoryCollectionCell.selectedSwitch.setOn(false, animated: true)
            }
        }
    }
    @IBAction func allCitiesDidToggle() {
        if allCitiesSwitch.isOn {
            for city in citiesCollectionController.cities {
                city.isSelected = true
            }
            for item in 0..<citiesCollectionView.numberOfItems(inSection: 0) {
                let simpleCityCollectionCell =
                    citiesCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as! SimpleCityCollectionCell
                simpleCityCollectionCell.selectedSwitch.setOn(true, animated: true)
            }
        }
        else {
            for city in citiesCollectionController.cities {
                city.isSelected = false
            }
            for item in 0..<citiesCollectionView.numberOfItems(inSection: 0) {
                let simpleCityCollectionCell =
                    citiesCollectionView.cellForItem(at: IndexPath(item: item, section: 0)) as! SimpleCityCollectionCell
                simpleCityCollectionCell.selectedSwitch.setOn(false, animated: true)
            }
        }
    }
    @IBAction func unlockedDidToggle() {
        if unlockedSwitch.isOn {
            unlockedSwitch.setOn(true, animated: true)
            lockedSwitch.setOn(false, animated: true)
            allSwitch.setOn(false, animated: true)
        }
        else {
            unlockedSwitch.setOn(true, animated: true)
        }
    }
    @IBAction func lockedDidToggle() {
        if lockedSwitch.isOn {
            unlockedSwitch.setOn(false, animated: true)
            lockedSwitch.setOn(true, animated: true)
            allSwitch.setOn(false, animated: true)
        }
        else {
            lockedSwitch.setOn(true, animated: true)
        }
    }
    @IBAction func allDidToggle() {
        if allSwitch.isOn {
            unlockedSwitch.setOn(false, animated: true)
            lockedSwitch.setOn(false, animated: true)
            allSwitch.setOn(true, animated: true)
        }
        else {
            allSwitch.setOn(true, animated: true)
        }
    }
    @IBAction func ApplyFilter() {
        let selectedCategoryIds = categoriesCollectionController.categories
            .filter { (category) in
                return category.isSelected
            }
            .map { (category) -> Int in
                return category.id
            }
        let selectedCityIds = citiesCollectionController.cities
            .filter { (city) in
                return city.isSelected
            }
            .map { (city) -> Int in
                return city.id
        }
        
        filterParameters = FilterParameters(
            categories: selectedCategoryIds,
            cities: selectedCityIds,
            searchedPhrase: filterParameters.searchedPhrase
        )
        
        applyFilterResponseController = ApplyFilterResponseController(viewController: self)
        applyFilterResponseController.requestHolder = request(RequestHolder(
            endPointName: .filter(parameters: filterParameters),
            didSucceed: applyFilterResponseController.didSucceed,
            didFail: applyFilterResponseController.didFail
        ))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLoadingState(.loading)
        filterScopesResponseController = FilterScopesResponseController(viewController: self)
        filterScopesResponseController.requestHolder = request(RequestHolder(
            endPointName: .filterScopes,
            didSucceed: filterScopesResponseController.didSucceed,
            didFail: filterScopesResponseController.didFail
        ))
    }
}
