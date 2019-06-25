import UIKit

class FinalizeViewController: ViewController {
    @IBOutlet weak var scrollView: ScrollView!
    @IBOutlet weak var addressView: View!
    @IBOutlet weak var numberOfProductsTitleLabel: Label!
    @IBOutlet weak var numberOfProductsLabel: Label!
    @IBOutlet weak var earnedPointsLabel: Label!
    @IBOutlet weak var totalPriceTitleLabel: Label!
    @IBOutlet weak var totalPriceLabel: Label!
    @IBOutlet weak var taxInclusiveLabel: Label!
    @IBOutlet weak var donateLabel: Label!
    @IBOutlet weak var donateSwitch: Switch!
    @IBOutlet weak var addressSelectionLabel: Label!
    @IBOutlet weak var addressesTableView: TableView!
    @IBOutlet weak var payButton: Button!
    @IBOutlet weak var resultLabel: Label!
    
    var addresses: [Address]!
    var addressesTableController: AddressesTableController!
    var cartResponseController: CartResponseController!
    var addOrderParameters: AddOrderParameters!
    var addOrderResponseController: AddOrderResponseController!
    
    @IBAction func pay() {
        resultLabel.fadeOut()
        
        var addressId = 0
        for address in addressesTableController.addresses {
            if address.isSelected {
                addressId = address.id
                break
            }
        }
        addOrderParameters = AddOrderParameters(
            charity: donateSwitch.isOn,
            addressId: addressId
        )
        addOrderResponseController = AddOrderResponseController(viewController: self)
        
        if addressId == 0 {
            resultLabel.text = texts(.selectOneOfYourAddresses)
            resultLabel.fadeIn()
        }
        else {
            payButton.setLoadingState(.loading)
            addOrderResponseController.requestHolder = request(RequestHolder(
                endPointName: .addOrder(parameters: addOrderParameters),
                didSucceed: addOrderResponseController.didSucceed,
                didFail: addOrderResponseController.didFail,
                blocking: true
            ))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            setLoadingState(.loading)
            cartResponseController = CartResponseController(viewController: self)
            cartResponseController.requestHolder = request(RequestHolder(
                endPointName: .cart,
                didSucceed: cartResponseController.didSucceed,
                didFail: cartResponseController.didFail,
                blocking: true
            ))
            
            refreshControl.containerView = scrollView
            refreshControl.requestHolder = cartResponseController.requestHolder
        }
    }
}

extension FinalizeViewController {
    func setAddressesHeight(numberOfAddresses: Int) {
        let addressHeight = 24 + scale * 2 * 6
        
        addressesTableView.heightConstraint.constant = CGFloat(numberOfAddresses) * addressHeight
    }
}
