import UIKit

class OrdersCollectionController: CollectionController {
    var orders: [OrderData] = []
    
    @objc func showDetails(sender: Button) {
        delay(durations(.interaction)) {
            let order = self.orders[sender.tag]
            self.viewController.navigateTo(.orderDetails, transferringData: order.id)
        }
    }
    
    override func itemHeight() -> CGFloat {
        let spacings: CGFloat = 8 * 12
        let staticHeights: CGFloat = 30
        let dynamicHeights = 6 * fonts(.medium).firstLineHeight
        
        return scale * (spacings + staticHeights) + dynamicHeights
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        orders = data as! [OrderData]
        let castedCell = cell as! OrderCollectionCell
        let order = orders[indexPath.item]
        
        castedCell.orderNumberTitleLabel.text = languageIsPersian ? "\(texts(.orderNumber).persian):" : "\(texts(.orderNumber).english):"
        castedCell.orderNumberLabel.text = order.orderNumber
        
        castedCell.totalPriceTitleLabel.text = languageIsPersian ? "\(texts(.totalPrice).persian):" : "\(texts(.totalPrice).english):"
        castedCell.totalPriceLabel.text = languageIsPersian ?
            "\(order.totalPrice.priceFormatted) \(texts(.currency).persian)" :
            "\(order.totalPrice.priceFormatted) \(texts(.currency).english)"
        
        castedCell.orderStatusTitleLabel.text = languageIsPersian ? "\(texts(.orderStatus).persian):" : "\(texts(.orderStatus).english):"
        castedCell.orderStatusLabel.text = order.status
        
        castedCell.transactionNumberTitleLabel.text = languageIsPersian ?
            "\(texts(.transactionNumber).persian):" :
            "\(texts(.transactionNumber).english):"
        castedCell.transactionNumberLabel.text = order.transactionNumber
        
        castedCell.paymentDateTitleLabel.text = languageIsPersian ? "\(texts(.paymentDate).persian):" : "\(texts(.paymentDate).english):"
        castedCell.paymentDateLabel.text = languageIsPersian ?
            "\(order.paymentDate.dateFormatted) \(texts(.hour).persian) \(order.paymentTime)" :
            "\(order.paymentDate.dateFormatted) \(texts(.hour).english) \(order.paymentTime)"
        
        castedCell.addressLabel.text = languageIsPersian ?
            "\(texts(.address).persian): \(order.address)" :
            "\(texts(.address).english): \(order.address)"
        
        castedCell.donatedLabel.isHidden = !order.donated
        
        castedCell.orderDetailsButton.tag = indexPath.item
        castedCell.orderDetailsButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        let order = orders[indexPath.item]
        viewController.navigateTo(.orderDetails, transferringData: order.id)
    }
}
