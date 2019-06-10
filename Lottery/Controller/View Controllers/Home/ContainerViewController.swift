import UIKit
import SnapKit

class ContainerViewController: ViewController {
    @IBOutlet weak var scrollView: ScrollView!
    @IBOutlet weak var pictureImageView: ImageView!
    @IBOutlet weak var descriptionView: View!
    @IBOutlet weak var nameLabel: Label!
    @IBOutlet weak var containerNameLabel: Label!
    @IBOutlet weak var descriptionLabel: Label!
    @IBOutlet weak var viewMoreButton: Button!
    @IBOutlet weak var topContentsLabel: Label!
    @IBOutlet weak var topContentsCollectionView: CollectionView!
    @IBOutlet weak var mapImageView: ImageView!
    @IBOutlet weak var hottestOffersLabel: Label!
    @IBOutlet weak var moreButton: Button!
    @IBOutlet weak var hottestOffersCollectionView: CollectionView!
    @IBOutlet weak var adImageView: ImageView!
    
    var container: Container!
    var details: ContainerDetails!
    
    var containerScrollController: ContainerScrollController!
    var topContentsCollectionController: ContainersCollectionController!
    var hottestOffersCollectionController: ProductsCollectionController!
    
    var initialDescriptionHeight: CGFloat!
    var finalDescriptionHeight: CGFloat!
    
    @IBAction func viewMore() {
        switch viewMoreButton.title(for: .normal) {
        case texts(.viewMore):
            descriptionLabel.heightConstraint.constant = finalDescriptionHeight
            viewMoreButton.setTitle(
                texts(.viewLess),
                for: .normal
            )
            
            UIView.animate(
                withDuration: durations(.springTextField),
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0,
                options: [],
                animations: {
                    self.view.layoutIfNeeded()
                    self.viewMoreButton.imageView!.transform = CGAffineTransform(rotationAngle: 180.degrees)
                },
                completion: nil
            )
        case texts(.viewLess):
            descriptionLabel.heightConstraint.constant = initialDescriptionHeight
            viewMoreButton.setTitle(
                texts(.viewMore),
                for: .normal
            )
            
            UIView.animate(
                withDuration: durations(.springTextField),
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0,
                options: [],
                animations: {
                    self.view.layoutIfNeeded()
                    self.viewMoreButton.imageView!.transform = CGAffineTransform(rotationAngle: 0.degrees)
                },
                completion: nil
            )
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picture: UIImage
        let containerName: String
        let topContents: [Container]!
        switch container.type {
        case .city:
            picture = container.picture
            containerName = ""
            topContents = [
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
        case .shoppingCenter:
            picture = #imageLiteral(resourceName: "testShoppingCenter")
            containerName = "تهران"
            topContents = [
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
        case .brand:
            picture = #imageLiteral(resourceName: "testBrand")
            containerName = "سام سنتر"
            topContents = nil
        }
        details = ContainerDetails(
            name: container.name,
            picture: picture,
            containerName: containerName,
            description: descriptionLabel.text!,
            topContents: topContents,
            locationPicture: #imageLiteral(resourceName: "testMap"),
            hottestOffers: [
                Product(
                    isUnlocked: true,
                    requiredPoints: 50,
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
                    requiredPoints: 40,
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
                    requiredPoints: 110,
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
                    requiredPoints: 75,
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
                    isUnlocked: false,
                    requiredPoints: 150,
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
            ad: Ad(picture: #imageLiteral(resourceName: "testAd1")),
            logoPicture: container.logoPicture
        )
        
        navigationItem.title = details.name
        pictureImageView.image = details.picture
        nameLabel.text = details.name
        descriptionLabel.text = details.description
        hottestOffersLabel.text = "\(texts(.hottestOffers)) \(details.name)"
        mapImageView.image = details.locationPicture
        adImageView.image = details.ad.picture
        
        containerNameLabel.text = " \(details.containerName)"
        switch container.type {
        case .city:
            topContentsLabel.text = texts(.topShoppingCenters)
        case .shoppingCenter:
            topContentsLabel.text = texts(.topBrands)
        case .brand:
            topContentsLabel.removeFromSuperview()
        }
        
        containerScrollController = ContainerScrollController(viewController: self, scrollView: scrollView)
        scrollView.delegate = containerScrollController
        
        if container.type == .brand {
            topContentsCollectionView.removeFromSuperview()
            hottestOffersLabel.removeFromSuperview()
            moreButton.removeFromSuperview()
            hottestOffersCollectionView.removeFromSuperview()
            
            mapImageView.snp.makeConstraints { (make) in
                make.top.equalTo(descriptionView.snp.bottom).offset(scale * 12)
            }
            adImageView.snp.makeConstraints { (make) in
                make.top.equalTo(mapImageView.snp.bottom).offset(scale * 24)
            }
        }
        else {
            topContentsCollectionController = ContainersCollectionController(
                viewController: self,
                collectionView: topContentsCollectionView
            )
            topContentsCollectionController.index = 1
            topContentsCollectionController.sharedData = [
                [],
                details.topContents
            ]
            topContentsCollectionView.dataSource = topContentsCollectionController
            topContentsCollectionView.delegate = topContentsCollectionController
            
            hottestOffersCollectionController = ProductsCollectionController(
                viewController: self,
                collectionView: hottestOffersCollectionView
            )
            hottestOffersCollectionController.index = 0
            hottestOffersCollectionController.sharedData = [details.hottestOffers]
            hottestOffersCollectionView.dataSource = hottestOffersCollectionController
            hottestOffersCollectionView.delegate = hottestOffersCollectionController
        }
        
        descriptionLabel.numberOfLines = 7
        initialDescriptionHeight = descriptionLabel.firstTextHeight
        descriptionLabel.heightConstraint.constant = initialDescriptionHeight
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        descriptionLabel.numberOfLines = 0
        finalDescriptionHeight = descriptionLabel.firstTextHeight
    }
}
