import UIKit

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
    var isCity: Bool!
    var details: ContainerDetails!
    
    var containerScrollController: ContainerScrollController!
    var topContentsCollectionController: ContainersCollectionController!
    var hottestOffersCollectionController: OffersCollectionController!
    
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
        
        let isCity = container.picture != nil
        let picture: UIImage
        let topContents: [Container]
        if isCity {
            picture = container.picture
            topContents = [
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter1"),
                    name: "سام سنتر"
                ),
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter2"),
                    name: "پالادیوم"
                ),
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter3"),
                    name: "مدرن الهیه"
                ),
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter4"),
                    name: "کوروش"
                ),
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testTopShoppingCenter5"),
                    name: "خلیج فارس"
                )
            ]
        }
        else {
            picture = #imageLiteral(resourceName: "testShoppingCenter")
            topContents = [
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testProductBrand1"),
                    name: "پینارلو"
                ),
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testProductBrand2"),
                    name: "گیونچای"
                ),
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testProductBrand3"),
                    name: "بنز"
                ),
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testProductBrand4"),
                    name: "لومیناکس"
                ),
                Container(
                    picture: nil,
                    logoPicture: #imageLiteral(resourceName: "testProductBrand5"),
                    name: "سامسونگ"
                )
            ]
        }
        details = ContainerDetails(
            name: container.name,
            picture: picture,
            containerName: "تهران",
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
        
        if !isCity {
            containerNameLabel.text = " \(details.containerName)"
        }
        if isCity {
            topContentsLabel.text = texts(.topShoppingCenters)
        }
        else {
            topContentsLabel.text = texts(.topBrands)
        }
        
        containerScrollController = ContainerScrollController(viewController: self, scrollView: scrollView)
        scrollView.delegate = containerScrollController
        
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
        
        hottestOffersCollectionController = OffersCollectionController(
            viewController: self,
            collectionView: hottestOffersCollectionView
        )
        hottestOffersCollectionController.index = 0
        hottestOffersCollectionController.sharedData = [details.hottestOffers]
        hottestOffersCollectionView.dataSource = hottestOffersCollectionController
        hottestOffersCollectionView.delegate = hottestOffersCollectionController
        
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
