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
    @IBOutlet weak var resultLabel: Label!
    @IBOutlet weak var secondBottomView: View!
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var addAddressButton: Button!
    @IBOutlet weak var addressesTableView: TableView!
    
    var profile: Profile!
    var section = PersonalInformationSection.account
    var addressesTableController: EditableAddressesTableController!
    var scrollController: ProfileSettingsScrollController!
    var updateProfileParameters: UpdateProfileParameters!
    var updateProfileResponseController: UpdateProfileResponseController!
    var updateNumberParameters: UpdateNumberParameters!
    var updateNumberResponseController: UpdateNumberResponseController!
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
    @IBAction func verify() {
        verifyButton.setLoadingState(.loading)
        
        updateNumberParameters = UpdateNumberParameters(
            mobileNumber: mobileNumberTextField.firstCommonMobileNumber
        )
        updateNumberResponseController = UpdateNumberResponseController(viewController: self)
        updateNumberResponseController.requestHolder = request(RequestHolder(
            endPointName: .updateNumber(parameters: updateNumberParameters),
            didSucceed: updateNumberResponseController.didSucceed,
            didFail: updateNumberResponseController.didFail,
            blocking: true
        ))
    }
    @IBAction func saveChanges() {
        saveChangesButton.setLoadingState(.loading)
        resultLabel.fadeOut()
        
        updateProfileParameters = UpdateProfileParameters(
            firstName: firstNameTextField.text!,
            lastName: lastNameTextField.text!,
            email: emailTextField.text!,
            password: passwordTextField.text!,
            mobileNumber: mobileNumberTextField.firstCommonMobileNumber,
            verificationCode: verificationCodeTextField.text!
        )
        updateProfileResponseController = UpdateProfileResponseController(viewController: self)
        updateProfileResponseController.requestHolder = request(RequestHolder(
            endPointName: .updateProfile(parameters: updateProfileParameters),
            didSucceed: updateProfileResponseController.didSucceed,
            didFail: updateProfileResponseController.didFail,
            blocking: true
        ))
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
    
    @IBAction func firstNameDidChange() {
        handleSaveAbility()
    }
    @IBAction func lastNameDidChange() {
        handleSaveAbility()
    }
    @IBAction func emailDidChange() {
        handleSaveAbility()
    }
    @IBAction func passwordDidChange() {
        if passwordTextField.isVerified && !passwordRepeatTextField.text!.isEmpty {
            if passwordRepeatTextField.text == passwordTextField.text {
                passwordTextField.verify()
            }
            else {
                passwordTextField.showError(texts(.unmatchedPasswords))
            }
        }
        
        handleSaveAbility()
    }
    @IBAction func passwordRepeatDidChange() {
        if passwordRepeatTextField.isVerified {
            if passwordRepeatTextField.text == passwordTextField.text {
                passwordRepeatTextField.verify()
            }
            else {
                passwordRepeatTextField.showError(texts(.unmatchedPasswords))
            }
        }
        
        handleSaveAbility()
    }
    @IBAction func mobileNumberDidChange() {
        if mobileNumberTextField.isVerified && mobileNumberTextField.firstCommonMobileNumber != profile.mobileNumber {
            verifyButton.enable()
        }
        else {
            verifyButton.disable()
        }
        
        handleSaveAbility()
    }
    @IBAction func verificationCodeDidChange() {
        if verificationCodeTextField.text!.count == 5 {
            verificationCodeTextField.verify()
        }
        else {
            verificationCodeTextField.showError(texts(.invalidVerificationCode))
        }
        
        handleSaveAbility()
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
        
        nameLabel.text = "\(profile.firstName) \(profile.lastName)"
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
        
        verifyButton.firstInteractionAnimationType = .glow
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

extension ProfileSettingsViewController {
    func fillTextFields() {
        if firstNameTextField.text!.isEmpty {
            firstNameTextField.prepareText()
        }
        if lastNameTextField.text!.isEmpty {
            lastNameTextField.prepareText()
        }
        if emailTextField.text!.isEmpty {
            emailTextField.prepareText()
        }
        if mobileNumberTextField.text!.isEmpty {
            mobileNumberTextField.prepareText()
        }
        
        self.firstNameTextField.text = self.profile.firstName
        self.lastNameTextField.text = self.profile.lastName
        self.emailTextField.text = self.profile.email
        self.mobileNumberTextField.text = self.profile.mobileNumber
        
        self.firstNameTextField.textDidChange()
        self.lastNameTextField.textDidChange()
        self.emailTextField.textDidChange()
        self.mobileNumberTextField.textDidChange()
    }
    
    private func handleSaveAbility() {
        if firstNameTextField.text!.isEmpty || lastNameTextField.text!.isEmpty || mobileNumberTextField.text!.isEmpty {
            saveChangesButton.disable()
        }
        else {
            if mobileNumberTextField.isVerified &&
                (emailTextField.text!.isEmpty || emailTextField.isVerified) &&
                ((passwordTextField.text!.isEmpty && passwordRepeatTextField.text!.isEmpty) || (passwordTextField.isVerified && passwordRepeatTextField.isVerified)) &&
                ((!verifyButton.isEnabled && verificationCodeTextField.text!.isEmpty) || (verifyButton.isEnabled && verificationCodeTextField.isVerified))
            {
                saveChangesButton.enable()
            }
            else {
                saveChangesButton.disable()
            }
        }
    }
}

enum PersonalInformationSection {
    case account
    case address
}
