import UIKit

class CityViewController: ViewController {
    @IBOutlet weak var pictureImageView: ImageView!
    @IBOutlet weak var descriptionView: View!
    @IBOutlet weak var nameLabel: Label!
    @IBOutlet weak var descriptionLabel: Label!
    @IBOutlet weak var viewMoreButton: Button!
    @IBOutlet weak var topShoppingCentersLabel: Label!
    @IBOutlet weak var topShoppingCentersCollectionView: CollectionView!
    @IBOutlet weak var mapImageView: ImageView!
    @IBOutlet weak var hottestOffersLabel: Label!
    @IBOutlet weak var moreButton: Button!
    
    var topShoppingCentersCollectionController: ContainersCollectionController!
    
    @IBAction func viewMore() {
        switch viewMoreButton.title(for: .normal) {
        case texts(.viewMore):
            descriptionLabel.numberOfLines = 0
            viewMoreButton.setTitle(
                texts(.viewLess),
                for: .normal
            )
            
            UIView.animate(withDuration: durations(.textField)) {
                self.view.layoutIfNeeded()
                self.viewMoreButton.imageView!.transform = CGAffineTransform(rotationAngle: 180.degrees)
            }
        case texts(.viewLess):
            descriptionLabel.numberOfLines = 7
            viewMoreButton.setTitle(
                texts(.viewMore),
                for: .normal
            )
            
            UIView.animate(withDuration: durations(.textField)) {
                self.view.layoutIfNeeded()
                self.viewMoreButton.imageView!.transform = CGAffineTransform(rotationAngle: 0.degrees)
            }
        default:
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topShoppingCentersCollectionController = ContainersCollectionController(
            viewController: self,
            collectionView: topShoppingCentersCollectionView
        )
        topShoppingCentersCollectionController.index = 1
        topShoppingCentersCollectionController.sharedData = [
            [],
            [
                Container(
                    picture: #imageLiteral(resourceName: "testTopShoppingCenter1"),
                    name: "سام سنتر"
                ),
                Container(
                    picture: #imageLiteral(resourceName: "testTopShoppingCenter2"),
                    name: "پالادیوم"
                ),
                Container(
                    picture: #imageLiteral(resourceName: "testTopShoppingCenter3"),
                    name: "مدرن الهیه"
                ),
                Container(
                    picture: #imageLiteral(resourceName: "testTopShoppingCenter4"),
                    name: "کوروش"
                ),
                Container(
                    picture: #imageLiteral(resourceName: "testTopShoppingCenter5"),
                    name: "خلیج فارس"
                )
            ]
        ]
        topShoppingCentersCollectionView.dataSource = topShoppingCentersCollectionController
        topShoppingCentersCollectionView.delegate = topShoppingCentersCollectionController
    }
}
