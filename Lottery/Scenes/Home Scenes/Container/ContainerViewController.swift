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
    
    var containerId: Int!
    var container: Container!
    var cityDetails: CityDetails!
    var shoppingCenterDetails: ShoppingCenterDetails!
    var brandDetails: BrandDetails!
    
    var containerScrollController: ContainerScrollController!
    var topContentsCollectionController: ContainersCollectionController!
    var hottestOffersCollectionController: ProductsCollectionController!
    var cityResponseController: CityResponseController!
    var shoppingCenterResponseController: ShoppingCenterResponseController!
    var brandResponseController: BrandResponseController!
    
    var expanded = false
    var initialDescriptionHeight: CGFloat!
    var finalDescriptionHeight: CGFloat!
    
    var mapTapRecognizer: UITapGestureRecognizer!
    
    @IBAction func viewMore() {
        if expanded {
            expanded = false
            
            descriptionLabel.heightConstraint.constant = initialDescriptionHeight
            viewMoreButton.setLocalizedTitle(
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
        }
        else {
            expanded = true
            
            descriptionLabel.heightConstraint.constant = finalDescriptionHeight
            viewMoreButton.setLocalizedTitle(
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
        }
    }
    
    @objc func showMap() {
        navigateTo(
            .map,
            transferringData: (container, cityDetails, shoppingCenterDetails, brandDetails)
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = container.name
        switch container.type {
        case .city:
            topContentsLabel.localizedText = texts(.topShoppingCenters)
        case .shoppingCenter:
            topContentsLabel.localizedText = texts(.topBrands)
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
                make.top.equalTo(viewMoreButton.snp.bottom).offset(scale * 12)
            }
            adImageView.snp.makeConstraints { (make) in
                make.top.equalTo(mapImageView.snp.bottom).offset(scale * 12)
            }
        }
        
        mapTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapImageView.addGestureRecognizer(mapTapRecognizer)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLoadingState(.loading)
        switch container.type {
        case .city:
            cityResponseController = CityResponseController(viewController: self)
            cityResponseController.requestHolder = request(RequestHolder(
                endPointName: .city(id: containerId),
                didSucceed: cityResponseController.didSucceed,
                didFail: cityResponseController.didFail,
                blocking: true
            ))
            
            refreshControl.containerView = scrollView
            refreshControl.requestHolder = cityResponseController.requestHolder
        case .shoppingCenter:
            shoppingCenterResponseController = ShoppingCenterResponseController(viewController: self)
            shoppingCenterResponseController.requestHolder = request(RequestHolder(
                endPointName: .shoppingCenter(id: containerId),
                didSucceed: shoppingCenterResponseController.didSucceed,
                didFail: shoppingCenterResponseController.didFail,
                blocking: true
            ))
            
            refreshControl.containerView = scrollView
            refreshControl.requestHolder = shoppingCenterResponseController.requestHolder
        default:
            brandResponseController = BrandResponseController(viewController: self)
            brandResponseController.requestHolder = request(RequestHolder(
                endPointName: .brand(id: containerId),
                didSucceed: brandResponseController.didSucceed,
                didFail: brandResponseController.didFail,
                blocking: true
            ))
            
            refreshControl.containerView = scrollView
            refreshControl.requestHolder = brandResponseController.requestHolder
        }
    }
}
