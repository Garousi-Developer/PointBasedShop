import UIKit

class ProfileViewController: ViewController {
    @IBOutlet weak var scrollView: ScrollView!
    @IBOutlet weak var shoppingCenterPictureImageView: ImageView!
    @IBOutlet weak var checkInView: View!
    @IBOutlet weak var welcomeLabel: Label!
    @IBOutlet weak var checkInDescriptionLabel: Label!
    @IBOutlet weak var checkInButton: Button!
    @IBOutlet weak var claimPointsDescriptionLabel: Label!
    @IBOutlet weak var claimPointsButton: Button!
    @IBOutlet weak var adImageView: ImageView!
    
    var awardsScrollController: AwardsScrollController!
    
    @IBAction func claimPoints() {
        delay(durations(.epsilon)) {
            self.navigateTo(.claimPoints)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = texts(.welcomeToXShoppingCenter).replacingOccurrences(of: texts(.shoppingCenterName), with: "سام سنتر")
        checkInDescriptionLabel.text = texts(.tapCheckInToClaimXLoyaltyPoints).replacingOccurrences(of: texts(.pointsAmount), with: "۵")
        claimPointsDescriptionLabel.text = texts(.takeYourTodaysInvoicesToXShoppingCenterCounter)
            .replacingOccurrences(of: texts(.shoppingCenterName), with: "سام سنتر")
            .replacingOccurrences(of: texts(.percentageAmount), with: "۲۰")
        
        awardsScrollController = AwardsScrollController(viewController: self, scrollView: scrollView)
        scrollView.delegate = awardsScrollController
    }
}
