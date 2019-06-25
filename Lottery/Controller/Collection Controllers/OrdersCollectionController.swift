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
        
        castedCell.orderNumberTitleLabel.text = "\(texts(.orderNumber)):"
        castedCell.orderNumberLabel.text = order.orderNumber
        
        castedCell.totalPriceTitleLabel.text = "\(texts(.totalPrice)):"
        castedCell.totalPriceLabel.text = "\(order.totalPrice.priceFormatted) \(texts(.currency))"
        
        castedCell.orderStatusTitleLabel.text = "\(texts(.orderStatus)):"
        castedCell.orderStatusLabel.text = order.status
        
        castedCell.transactionNumberTitleLabel.text = "\(texts(.transactionNumber)):"
        castedCell.transactionNumberLabel.text = order.transactionNumber
        
        castedCell.paymentDateTitleLabel.text = "\(texts(.paymentDate)):"
        castedCell.paymentDateLabel.text = "\(order.paymentDate.dateFormatted) \(texts(.hour)) \(order.paymentTime)"
        
        castedCell.addressLabel.text = "\(texts(.address)): \(order.address)"
        
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
