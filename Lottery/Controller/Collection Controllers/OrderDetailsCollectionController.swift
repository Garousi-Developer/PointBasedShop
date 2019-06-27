import UIKit

class OrderDetailsCollectionController: CollectionController {
    var orderItems: [OrderItem] = []
    
    override func itemHeight() -> CGFloat {
        let spacings: CGFloat = 5 * 12 + 2 * 6
        let staticHeights: CGFloat = 120 + 40
        let dynamicHeights = 3 * fonts(.medium).firstLineHeight + fonts(.semiSmall).firstLineHeight
        
        return scale * (spacings + staticHeights) + dynamicHeights
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        orderItems = data as! [OrderItem]
        let castedCell = cell as! OrderDetailCollectionCell
        let orderItem = orderItems[indexPath.item]
        
        castedCell.productImageView.downloadImageFrom(orderItem.pictureURL)
        castedCell.productNameLabel.text = orderItem.persianTitle
        castedCell.productCountLabel.text = "\(orderItem.count) \(texts(.count))"
        castedCell.brandImageView.downloadImageFrom(orderItem.brand.logoURL)
        castedCell.brandNameLabel.text = orderItem.brand.persianTitle
        
        setupExpensesLabel(castedCell, orderItem)
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        let orderItem = orderItems[indexPath.item]
        viewController.navigateTo(.product, transferringData: (orderItem.persianTitle, orderItem.id))
    }
}

extension OrderDetailsCollectionController {
        private func setupExpensesLabel(_ castedCell: OrderDetailCollectionCell, _ orderItem: OrderItem) {
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
