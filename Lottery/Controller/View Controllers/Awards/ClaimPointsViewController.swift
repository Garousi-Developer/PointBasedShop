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
        purchaseAmountTextField.text = purchaseAmountTextField.text?.priceFormatted
        handleSubmitAbility()
    }
    @IBAction func employeeIdDidChange() {
        handleSubmitAbility()
    }
    @IBAction func submit() {
        resultLabel.fadeOut()
        
        let purchaseAmount = purchaseAmountTextField.text!.replacingOccurrences(of: "٫", with: "")
        claimPointsParameters = ClaimPointsParameters(
            shoppingCenterId: awards.id,
            purchaseAmount: Int(purchaseAmount)!,
            employeeId: Int(employeeIdTextField.text!)!,
            secretToken: pinView.getPin()
        )
        responseController = ClaimPointsResponseController(viewController: self)
        
        submitButton.setLoadingState(.loading)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .claimPoints(parameters: claimPointsParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: true
        ))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        respondersSuperView = submitView
        
        shoppingCenterPictureImageView.downloadImageFrom(awards.pictureURL)
        welcomeLabel.text = languageIsPersian ?
            texts(.welcomeToXShoppingCenter).persian
                .replacingOccurrences(of: texts(.shoppingCenterName).persian, with: awards.persianTitle) :
            texts(.welcomeToXShoppingCenter).english
                .replacingOccurrences(of: texts(.shoppingCenterName).english, with: awards.englishTitle)
        adImageView.downloadImageFrom(awards.ad.pictureURL)
        
        claimPointsScrollController = ClaimPointsScrollController(viewController: self, scrollView: scrollView)
        scrollView.delegate = claimPointsScrollController
    }
}

extension ClaimPointsViewController {
    private func handleSubmitAbility() {
        if purchaseAmountTextField.text!.isEmpty || employeeIdTextField.text!.isEmpty {       //  || pinView.getPin().isEmpty
            submitButton.disable()
        }
        else {
            if employeeIdTextField.text!.count == 4 {
                employeeIdTextField.verify()
                submitButton.enable()
            }
            else {
                employeeIdTextField.showError(texts(.invalidEmployeeId))
                submitButton.disable()
            }
        }
    }
}
