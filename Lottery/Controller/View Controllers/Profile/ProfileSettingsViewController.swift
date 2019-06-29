import UIKit

class ProfileSettingsViewController: ViewController {
    @IBOutlet weak var scrollView: ScrollView!
    @IBOutlet weak var sectionsStackView: StackView!
    @IBOutlet weak var accountButton: Button!
    @IBOutlet weak var addressButton: Button!
    @IBOutlet weak var bottomView: View!
    @IBOutlet weak var nameLabel: Label!
    @IBOutlet weak var registerationDateLabel: Label!
    @IBOutlet weak var firstNameTextField: FirstTextField!
    @IBOutlet weak var lastNameTextField: FirstTextField!
    @IBOutlet weak var emailTextField: FirstTextField!
    @IBOutlet weak var passwordTextField: FirstTextField!
    @IBOutlet weak var passwordRepeatTextField: FirstTextField!
    @IBOutlet weak var mobileNumberTextField: FirstTextField!
    @IBOutlet weak var verifyButton: Button!
    @IBOutlet weak var verificationCodeTextField: FirstTextField!
    @IBOutlet weak var saveChangesButton: Button!
    
    var section = PersonalInformationSection.account
    
    @IBAction func showAccount() {
        section = .account
        
//        productDetailsTableView.fadeOut()
//        descriptionLabel.fadeIn()
        
        UIView.animate(withDuration: durations(.textField)) {
            self.accountButton.backgroundColor = colors(.white)
            self.addressButton.backgroundColor = colors(.darkPlaceholder)
        }
    }
    @IBAction func showAddress() {
        section = .address
        
//        descriptionLabel.fadeOut()
//        productDetailsTableView.fadeIn()
        
        UIView.animate(withDuration: durations(.textField)) {
            self.addressButton.backgroundColor = colors(.white)
            self.accountButton.backgroundColor = colors(.darkPlaceholder)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        respondersSuperView = bottomView
        scrollView.delaysContentTouches = true
    }
}

enum PersonalInformationSection {
    case account
    case address
}
