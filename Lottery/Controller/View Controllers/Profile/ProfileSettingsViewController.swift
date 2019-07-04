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
    @IBOutlet weak var secondBottomView: View!
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var addAddressButton: Button!
    @IBOutlet weak var addressesTableView: TableView!
    
    var section = PersonalInformationSection.account
    var addressesTableController: EditableAddressesTableController!
    var scrollController: ProfileSettingsScrollController!
    var addressesResponseController: AddressesResponseController!
    
    @IBAction func showAccount() {
        section = .account
        
        secondBottomView.fadeOut()
        bottomView.fadeIn()
        
        UIView.animate(withDuration: durations(.textField)) {
            self.accountButton.backgroundColor = colors(.white)
            self.addressButton.backgroundColor = colors(.darkPlaceholder)
        }
        
        respondersSuperView = bottomView
    }
    @IBAction func showAddress() {
        section = .address
        
        bottomView.fadeOut()
        secondBottomView.fadeIn()
        
        UIView.animate(withDuration: durations(.textField)) {
            self.addressButton.backgroundColor = colors(.white)
            self.accountButton.backgroundColor = colors(.darkPlaceholder)
        }
        
        respondersSuperView = addressesTableView
    }
    @IBAction func addAddress() {
        addressesTableController.data.append(NewAddress(id: 0, address: ""))
        
        CATransaction.setCompletionBlock {
            let addressTableCell = self.addressesTableView.cellForRow(at: IndexPath(
                row: self.addressesTableController.data.count - 1,
                section: 0
            )) as! EditableAddressTableCell
            addressTableCell.addressTextField.becomeFirstResponder()
        }
        CATransaction.begin()
        addressesTableView.insertRows(
            at: [IndexPath(
                row: addressesTableController.data.count - 1,
                section: 0
            )],
            with: .automatic
        )
        CATransaction.commit()
    }
    
    func showAddressWithoutAnimation() {
        section = .address
        
        bottomView.alpha = 0
        secondBottomView.alpha = 1
        
        self.addressButton.backgroundColor = colors(.white)
        self.accountButton.backgroundColor = colors(.darkPlaceholder)
        
        respondersSuperView = addressesTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = languageIsPersian ? "آرمان گروسی" : "Arman Garousi"
        registerationDateLabel.text = languageIsPersian ? "عضو از : ۲۰ فروردین ۹۸" : "Member since : 20 April 2019"
        
        addressesTableController = EditableAddressesTableController(
            viewController: self,
            tableView: addressesTableView
        )
        addressesTableView.dataSource = addressesTableController
        addressesTableView.delegate = addressesTableController
        
        respondersSuperView = bottomView
        scrollView.delaysContentTouches = true
        
        scrollController = ProfileSettingsScrollController(viewController: self, scrollView: scrollView)
        scrollView.delegate = scrollController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLoadingState(.loading)
        addressesResponseController = AddressesResponseController(viewController: self)
        addressesResponseController.requestHolder = request(RequestHolder(
            endPointName: .cart,
            didSucceed: addressesResponseController.didSucceed,
            didFail: addressesResponseController.didFail,
            blocking: true
        ))
        
        refreshControl.containerView = scrollView
        refreshControl.requestHolder = addressesResponseController.requestHolder
    }
}

enum PersonalInformationSection {
    case account
    case address
}
