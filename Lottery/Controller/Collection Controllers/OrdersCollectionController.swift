import UIKit

class OrdersCollectionController: CollectionController {
    var orders: [OrderData] = []
    
    override func itemHeight() -> CGFloat {
        let firstSpacings: CGFloat = 3 * 24 + 7 * 12
        let secondSpacings: CGFloat = 2 * 6
        let staticHeights: CGFloat = 160
        let dynamicHeights = fonts(.semiLarge).firstLineHeight + 5 * fonts(.medium).firstLineHeight + 2 * fonts(.semiSmall).firstLineHeight
        
        return scale * (firstSpacings + secondSpacings + staticHeights) + dynamicHeights
//        return scale * 475
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        orders = data as! [OrderData]
        let castedCell = cell as! OrderCollectionCell
        let order = orders[indexPath.item]
        let orderItem = order.items[0]
        
        castedCell.orderNumberLabel.text = "\(texts(.orderNumber)): \(order.orderNumber)"
        castedCell.transactionNumberLabel.text = "\(texts(.transactionNumber)): \(order.transactionNumber)"
        castedCell.orderStateLabel.text = order.state
        castedCell.charityStateLabel.text = texts(.donatedToCharity)
        
        castedCell.productImageView.downloadImageFrom(orderItem.pictureURL)
        castedCell.productNameLabel.text = orderItem.persianTitle
        castedCell.productCountLabel.text = "\(orderItem.count) \(texts(.count))"
        castedCell.productBrandImageView.downloadImageFrom(orderItem.brand.logoURL)
        castedCell.productBrandNameLabel.text = orderItem.brand.persianTitle
        
        castedCell.addressTitleLabel.text = texts(.address)
        castedCell.addressLabel.text = order.address
        
        setupExpensesLabel(castedCell, orderItem)
    }
}

extension OrdersCollectionController {
    private func setupExpensesLabel(_ castedCell: OrderCollectionCell, _ orderItem: OrderItem) {
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(
            string: orderItem.totalPrice.priceFormatted
        ))
        attributedText.append(NSAttributedString(
            string: " "
        ))
        attributedText.append(NSAttributedString(
            string: texts(.currency),
            attributes: [
                NSAttributedString.Key.foregroundColor: colors(.asset)
            ]
        ))
        attributedText.append(NSAttributedString(
            string: " + ",
            attributes: [
                NSAttributedString.Key.foregroundColor: colors(.asset)
            ]
        ))
        attributedText.append(NSAttributedString(
            string: orderItem.totalPoints.priceFormatted
        ))
        attributedText.append(NSAttributedString(
            string: " "
        ))
        attributedText.append(NSAttributedString(
            string: texts(.points),
            attributes: [
                NSAttributedString.Key.foregroundColor: colors(.asset)
            ]
        ))
        
        castedCell.productExpensesLabel.attributedText = attributedText
    }
}
