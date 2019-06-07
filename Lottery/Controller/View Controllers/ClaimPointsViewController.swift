import UIKit

class ClaimPointsViewController: ViewController {
    @IBOutlet weak var scrollView: ScrollView!
    @IBOutlet weak var shoppingCenterPictureImageView: ImageView!
    @IBOutlet weak var submitView: View!
    @IBOutlet weak var welcomeLabel: Label!
    @IBOutlet weak var descriptionLabel: Label!
    @IBOutlet weak var purchaseAmountTextField: FirstTextField!
    @IBOutlet weak var employeeIdTextField: FirstTextField!
    @IBOutlet weak var secretTokenLabel: Label!
    @IBOutlet weak var pinView: PinView!
    @IBOutlet weak var submitButton: Button!
    @IBOutlet weak var adImageView: ImageView!
    
    var claimPointsScrollController: ClaimPointsScrollController!
    
    @IBAction func purchaseAmountDidChange() {
        purchaseAmountTextField.text = purchaseAmountTextField.text?.priceFormatted
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = texts(.welcomeToXShoppingCenter).replacingOccurrences(of: texts(.shoppingCenterName), with: "سام سنتر")
        
        claimPointsScrollController = ClaimPointsScrollController(viewController: self, scrollView: scrollView)
        scrollView.delegate = claimPointsScrollController
    }
}

