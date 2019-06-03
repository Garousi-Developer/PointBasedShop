import UIKit

class ClaimPointsViewController: ViewController {
    @IBOutlet weak var scrollView: ScrollView!
    @IBOutlet weak var shoppingCenterPictureImageView: ImageView!
    @IBOutlet weak var submitView: View!
    @IBOutlet weak var welcomeLabel: Label!
    @IBOutlet weak var descriptionLabel: Label!
    @IBOutlet weak var submitButton: Button!
    @IBOutlet weak var adImageView: ImageView!
    
    var claimPointsScrollController: ClaimPointsScrollController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = texts(.welcomeToXShoppingCenter).replacingOccurrences(of: "نام مرکز خرید", with: "سام سنتر")
        
        claimPointsScrollController = ClaimPointsScrollController(viewController: self, scrollView: scrollView)
        scrollView.delegate = claimPointsScrollController
    }
}

