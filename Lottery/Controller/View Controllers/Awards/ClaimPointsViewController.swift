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
    @IBOutlet weak var resultLabel: Label!
    @IBOutlet weak var adImageView: ImageView!
    
    var awards: Awards!
    var claimPointsScrollController: ClaimPointsScrollController!
    var claimPointsParameters: ClaimPointsParameters!
    var responseController: ClaimPointsResponseController!
    
    @IBAction func purchaseAmountDidChange() {
//        purchaseAmountTextField.text = purchaseAmountTextField.text?.priceFormatted
    }
    @IBAction func employeeIdDidChange() {
        
    }
    @IBAction func submit() {
        resultLabel.fadeOut()
        
        claimPointsParameters = ClaimPointsParameters(
            shoppingCenterId: awards.id,
            purchaseAmount: Int(purchaseAmountTextField.text!)!,
            employeeId: Int(employeeIdTextField.text!)!,
            secretToken: pinView.getPin()
        )
        responseController = ClaimPointsResponseController(viewController: self)
        
        responseController.requestHolder = request(RequestHolder(
            endPointName: .claimPoints(parameters: claimPointsParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail
        ))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingCenterPictureImageView.downloadImageFrom(awards.pictureURL)
        welcomeLabel.text = texts(.welcomeToXShoppingCenter).replacingOccurrences(of: texts(.shoppingCenterName), with: awards.persianTitle)
        adImageView.downloadImageFrom(awards.ad.pictureURL)
        
        claimPointsScrollController = ClaimPointsScrollController(viewController: self, scrollView: scrollView)
        scrollView.delegate = claimPointsScrollController
    }
}

