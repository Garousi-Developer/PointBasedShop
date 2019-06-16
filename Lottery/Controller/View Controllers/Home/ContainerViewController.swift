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
    
    var cityId: Int!
    var container: Container!
    
    var containerScrollController: ContainerScrollController!
    var topContentsCollectionController: ContainersCollectionController!
    var hottestOffersCollectionController: ProductsCollectionController!
    var cityResponseController: CityResponseController!
    var shoppingCenterResponseController: ShoppingCenterResponseController!
    var brandResponseController: CityResponseController!
    
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
        
        navigationItem.title = container.name
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
        
        setLoadingState(.loading)
        switch container.type {
        case .city:
            cityResponseController = CityResponseController(viewController: self)
            cityResponseController.requestHolder = request(RequestHolder(
                endPointName: .city(id: cityId),
                didSucceed: cityResponseController.didSucceed,
                didFail: cityResponseController.didFail
            ))
        case .shoppingCenter:
            shoppingCenterResponseController = ShoppingCenterResponseController(viewController: self)
            shoppingCenterResponseController.requestHolder = request(RequestHolder(
                endPointName: .shoppingCenter(id: cityId),
                didSucceed: shoppingCenterResponseController.didSucceed,
                didFail: shoppingCenterResponseController.didFail
            ))
        default:
            break
        }
        
        descriptionLabel.numberOfLines = 7
        initialDescriptionHeight = descriptionLabel.firstTextHeight
        descriptionLabel.heightConstraint.constant = initialDescriptionHeight
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        hottestOffersCollectionView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        descriptionLabel.numberOfLines = 0
        finalDescriptionHeight = descriptionLabel.firstTextHeight
    }
}
