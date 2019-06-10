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
                    isSelected: false,
                    title: "دیجیتال"
                ),
                SimpleCategory(
                    isSelected: false,
                    title: "آرایشی"
                ),
                SimpleCategory(
                    isSelected: false,
                    title: "خودرو"
                ),
                SimpleCategory(
                    isSelected: false,
                    title: "پوشاک"
                ),
                SimpleCategory(
                    isSelected: false,
                    title: "لوازم خانگی"
                ),
                SimpleCategory(
                    isSelected: false,
                    title: "اسباب بازی"
                ),
                SimpleCategory(
                    isSelected: false,
                    title: "ورزشی"
                )
            ],
            cities: [
                SimpleCity(
                    isSelected: false,
                    name: "تهران"
                ),
                SimpleCity(
                    isSelected: false,
                    name: "اهواز"
                ),
                SimpleCity(
                    isSelected: false,
                    name: "اصفهان"
                ),
                SimpleCity(
                    isSelected: false,
                    name: "مشهد"
                ),
                SimpleCity(
                    isSelected: false,
                    name: "شیراز"
                ),
                SimpleCity(
                    isSelected: false,
                    name: "ساری"
                ),
                SimpleCity(
                    isSelected: false,
                    name: "تبریز"
                )
            ]
        )
        
        categoriesCollectionController = SimpleCategoriesCollectionController(
            viewController: self,
            collectionView: categoriesCollectionView
        )
        categoriesCollectionController.index = 0
        categoriesCollectionController.sharedData = [filter.categories]
        categoriesCollectionView.dataSource = categoriesCollectionController
        categoriesCollectionView.delegate = categoriesCollectionController
        
        citiesCollectionController = SimpleCitiesCollectionController(
            viewController: self,
            collectionView: citiesCollectionView
        )
        citiesCollectionController.index = 0
        citiesCollectionController.sharedData = [filter.cities]
        citiesCollectionView.dataSource = citiesCollectionController
        citiesCollectionView.delegate = citiesCollectionController
    }
}
