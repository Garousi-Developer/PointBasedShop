import UIKit

class HomeViewController: ViewController {
    @IBOutlet weak var homeTableView: TableView!
    
    var homeTableController: HomeTableController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableController = HomeTableController(viewController: self, tableView: homeTableView)
        homeTableController.data = [
            TopStaticHome(
                sliderAds: [Ad(picture: #imageLiteral(resourceName: "testSlider1")), Ad(picture: #imageLiteral(resourceName: "testSlider2")), Ad(picture: #imageLiteral(resourceName: "testSlider3")), Ad(picture: #imageLiteral(resourceName: "testSlider4")), Ad(picture: #imageLiteral(resourceName: "testSlider5"))],
                userPoints: 110,
                categories: [
                    Category(
                        picture: #imageLiteral(resourceName: "testCategory1"),
                        title: "دیجیتال"
                    ),
                    Category(
                        picture: #imageLiteral(resourceName: "testCategory2"),
                        title: "آرایشی"
                    ),
                    Category(
                        picture: #imageLiteral(resourceName: "testCategory3"),
                        title: "خودرو"
                    ),
                    Category(
                        picture: #imageLiteral(resourceName: "testCategory4"),
                        title: "پوشاک"
                    ),
                    Category(
                        picture: #imageLiteral(resourceName: "testCategory5"),
                        title: "لوازم خانگی"
                    ),
                    Category(
                        picture: #imageLiteral(resourceName: "testCategory6"),
                        title: "اسباب بازی"
                    ),
                    Category(
                        picture: #imageLiteral(resourceName: "testCategory7"),
                        title: "ورزشی"
                    )
                ],
                closestProducts: [
                    Product(
                        isUnlocked: true,
                        requiredPoints: 85,
                        isFavorite: false,
                        picture: #imageLiteral(resourceName: "testProduct1"),
                        name: "دوچرخه",
                        price: 6500000,
                        discountedPrice: 5200000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand1"),
                        orderCount: 0,
                        numberOfSoldProducts: 320,
                        numberOfProducts: 375
                    ),
                    Product(
                        isUnlocked: true,
                        requiredPoints: 20,
                        isFavorite: false,
                        picture: #imageLiteral(resourceName: "testProduct2"),
                        name: "کیف زنانه",
                        price: 620000,
                        discountedPrice: 500000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand2"),
                        orderCount: 0,
                        numberOfSoldProducts: 249,
                        numberOfProducts: 385
                    ),
                    Product(
                        isUnlocked: true,
                        requiredPoints: 85,
                        isFavorite: true,
                        picture: #imageLiteral(resourceName: "testProduct3"),
                        name: "مرسدس بنز",
                        price: 4000000000,
                        discountedPrice: 3200000000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand3"),
                        orderCount: 0,
                        numberOfSoldProducts: 339,
                        numberOfProducts: 1125
                    ),
                    Product(
                        isUnlocked: true,
                        requiredPoints: 45,
                        isFavorite: false,
                        picture: #imageLiteral(resourceName: "testProduct4"),
                        name: "ساعت مچی",
                        price: 3400000,
                        discountedPrice: 2700000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand4"),
                        orderCount: 0,
                        numberOfSoldProducts: 97,
                        numberOfProducts: 175
                    ),
                    Product(
                        isUnlocked: true,
                        requiredPoints: 75,
                        isFavorite: true,
                        picture: #imageLiteral(resourceName: "testProduct5"),
                        name: "تلویزیون",
                        price: 18000000,
                        discountedPrice: 14000000,
                        brandLogo: #imageLiteral(resourceName: "testProductBrand5"),
                        orderCount: 0,
                        numberOfSoldProducts: 102,
                        numberOfProducts: 200
                    )
                ],
                ad: Ad(picture: #imageLiteral(resourceName: "testAd1"))
            ),
            DynamicHome(
                sections: [
                    DynamicHomeSection(
                        title: texts(.cities),
                        containers: [
                            Container(
                                type: .city,
                                picture: #imageLiteral(resourceName: "testCity1"),
                                logoPicture: nil,
                                name: "تهران"
                            ),
                            Container(
                                type: .city,
                                picture: #imageLiteral(resourceName: "testCity2"),
                                logoPicture: nil,
                                name: "اهواز"
                            ),
                            Container(
                                type: .city,
                                picture: #imageLiteral(resourceName: "testCity3"),
                                logoPicture: nil,
                                name: "اصفهان"
                            ),
                            Container(
                                type: .city,
                                picture: #imageLiteral(resourceName: "testCity4"),
                                logoPicture: nil,
                                name: "مشهد"
                            ),
                            Container(
                                type: .city,
                                picture: #imageLiteral(resourceName: "testCity5"),
                                logoPicture: nil,
                                name: "شیراز"
                            ),
                            Container(
                                type: .city,
                                picture: #imageLiteral(resourceName: "testCity6"),
                                logoPicture: nil,
                                name: "ساری"
                            ),
                            Container(
                                type: .city,
                                picture: #imageLiteral(resourceName: "testCity7"),
                                logoPicture: nil,
                                name: "تبریز"
                            )
                        ]
                    ),
                    DynamicHomeSection(
                        title: texts(.topShoppingCenters),
                        containers: [
                            Container(
                                type: .shoppingCenter,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter1"),
                                name: "سام سنتر"
                            ),
                            Container(
                                type: .shoppingCenter,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter2"),
                                name: "پالادیوم"
                            ),
                            Container(
                                type: .shoppingCenter,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter3"),
                                name: "مدرن الهیه"
                            ),
                            Container(
                                type: .shoppingCenter,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter4"),
                                name: "کوروش"
                            ),
                            Container(
                                type: .shoppingCenter,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter5"),
                                name: "خلیج فارس"
                            )
                        ]
                    ),
                    DynamicHomeSection(
                        title: texts(.topBrands),
                        containers: [
                            Container(
                                type: .brand,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testProductBrand1"),
                                name: "پینارلو"
                            ),
                            Container(
                                type: .brand,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testProductBrand2"),
                                name: "گیونچای"
                            ),
                            Container(
                                type: .brand,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testProductBrand3"),
                                name: "بنز"
                            ),
                            Container(
                                type: .brand,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testProductBrand4"),
                                name: "لومیناکس"
                            ),
                            Container(
                                type: .brand,
                                picture: nil,
                                logoPicture: #imageLiteral(resourceName: "testProductBrand5"),
                                name: "سامسونگ"
                            )
                        ]
                    )
                ]
            ),
            BottomStaticHome(
                ad: Ad(picture: #imageLiteral(resourceName: "testAd2"))
            )
        ]
        homeTableView.dataSource = homeTableController
        homeTableView.delegate = homeTableController
    }
}
