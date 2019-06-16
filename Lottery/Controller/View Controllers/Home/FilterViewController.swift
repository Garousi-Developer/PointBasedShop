import UIKit

class FilterViewController: ViewController {
    @IBOutlet weak var categoriesLabel: Label!
    @IBOutlet weak var categoriesCollectionView: CollectionView!
    @IBOutlet weak var citiesLabel: Label!
    @IBOutlet weak var citiesCollectionView: CollectionView!
    @IBOutlet weak var unlockedLabel: Label!
    @IBOutlet weak var unlockedSwitch: Switch!
    @IBOutlet weak var lockedLabel: Label!
    @IBOutlet weak var lockedSwitch: Switch!
    @IBOutlet weak var allLabel: Label!
    @IBOutlet weak var allSwitch: Switch!
    @IBOutlet weak var filterButton: Button!
    
    var filter: Filter!
    
    var categoriesCollectionController: SimpleCategoriesCollectionController!
    var citiesCollectionController: SimpleCitiesCollectionController!
    
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filter = Filter(
            categories: [
                SimpleCategory(
                    title: "دیجیتال",
                    isSelected: false
                ),
                SimpleCategory(
                    title: "آرایشی",
                    isSelected: false
                ),
                SimpleCategory(
                    title: "خودرو",
                    isSelected: false
                ),
                SimpleCategory(
                    title: "پوشاک",
                    isSelected: false
                ),
                SimpleCategory(
                    title: "لوازم خانگی",
                    isSelected: false
                ),
                SimpleCategory(
                    title: "اسباب بازی",
                    isSelected: false
                ),
                SimpleCategory(
                    title: "ورزشی",
                    isSelected: false
                )
            ],
            cities: [
                SimpleCity(
                    name: "تهران",
                    isSelected: false
                ),
                SimpleCity(
                    name: "اهواز",
                    isSelected: false
                ),
                SimpleCity(
                    name: "اصفهان",
                    isSelected: false
                ),
                SimpleCity(
                    name: "مشهد",
                    isSelected: false
                ),
                SimpleCity(
                    name: "شیراز",
                    isSelected: false
                ),
                SimpleCity(
                    name: "ساری",
                    isSelected: false
                ),
                SimpleCity(
                    name: "تبریز",
                    isSelected: false
                )
            ]
        )
        
        categoriesCollectionController = SimpleCategoriesCollectionController(
            viewController: self,
            collectionView: categoriesCollectionView
        )
        categoriesCollectionController.data = filter.categories
        categoriesCollectionView.dataSource = categoriesCollectionController
        categoriesCollectionView.delegate = categoriesCollectionController
        
        citiesCollectionController = SimpleCitiesCollectionController(
            viewController: self,
            collectionView: citiesCollectionView
        )
        citiesCollectionController.data = filter.cities
        citiesCollectionView.dataSource = citiesCollectionController
        citiesCollectionView.delegate = citiesCollectionController
    }
}
