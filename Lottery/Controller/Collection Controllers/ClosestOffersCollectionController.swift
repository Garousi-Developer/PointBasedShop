import UIKit

class ClosestOffersCollectionController: CollectionController {
    var closestProducts: [Product] = []
    var isFirstTime = true
    
    @objc func toggleFavoriteState(sender: Button) {
        closestProducts[sender.tag].isFavorite.toggle()
        
        delay(durations(.interaction)) {
            self.collectionView.reloadItems(at: [IndexPath(
                item: sender.tag,
                section: 0
            )])
            
            if self.closestProducts[sender.tag].isFavorite {
                sender.tintColor = colors(.red)
            }
            else {
                sender.tintColor = colors(.asset)
            }
        }
    }
    @objc func addToCart(sender: Button) {
        let cell = collectionView.cellForItem(at: IndexPath(
            item: sender.tag,
            section: 0
        )) as! ClosestOfferCollectionCell
        
        closestProducts[sender.tag].orderCount += 1
        
        delay(durations(.interaction)) {
            self.collectionView.reloadItems(at: [IndexPath(
                item: sender.tag,
                section: 0
            )])
            
            cell.addToCartButton.fadeOut()
            cell.orderCountStackView.fadeIn()
        }
    }
    @objc func decrement(sender: Button) {
        let cell = collectionView.cellForItem(at: IndexPath(
            item: sender.tag,
            section: 0
        )) as! ClosestOfferCollectionCell
        
        closestProducts[sender.tag].orderCount -= 1
        
        delay(durations(.interaction)) {
            self.collectionView.reloadItems(at: [IndexPath(
                item: sender.tag,
                section: 0
            )])
            
            if self.closestProducts[sender.tag].orderCount == 0 {
                cell.orderCountStackView.fadeOut()
                cell.addToCartButton.fadeIn()
            }
        }
    }
    @objc func increment(sender: Button) {
        closestProducts[sender.tag].orderCount += 1
        
        delay(durations(.interaction)) {
            self.collectionView.reloadItems(at: [IndexPath(
                item: sender.tag,
                section: 0
            )])
        }
    }
    
    override func itemHeight() -> CGFloat {
        let firstSpacings: CGFloat = 2 * 18 + 3 * 12
        let secondSpacings: CGFloat = 2 * 6 + 3
        let constantHeights: CGFloat = 36
        let staticHeights: CGFloat = 120 + 40 + 35 + 5
        let dynamicHeights = 2 * fonts(.medium).firstLineHeight
        
        return constantHeights + scale * (firstSpacings + secondSpacings + staticHeights) + dynamicHeights
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        if isFirstTime {
            isFirstTime = false
            
            closestProducts = sharedData[index] as! [Product]
        }
        
        let castedCell = cell as! ClosestOfferCollectionCell
        let product = closestProducts[indexPath.item]
        let progress = CGFloat(product.numberOfSoldProducts) / CGFloat(product.numberOfProducts)
        
        castedCell.requiredPointsLabel.text = "\(product.requiredPoints) \(texts(.points))"
        castedCell.pictureImageView.image = product.picture
        castedCell.brandImageView.image = product.brandLogo
        castedCell.orderCountButton.setTitle(
            "\(product.orderCount)",
            for: .normal
        )
        castedCell.numberOfSoldProductsLabel.text = "\(product.numberOfSoldProducts) \(texts(.number)) \(texts(.sold))"
        castedCell.numberOfProductsLabel.text = "\(texts(.outOf)) \(product.numberOfProducts) \(texts(.number))"
        
        if product.isFavorite {
            castedCell.favoriteButton.tintColor = colors(.red)
        }
        else {
            castedCell.favoriteButton.tintColor = colors(.asset)
        }
        if product.orderCount == 0 {
            castedCell.addToCartButton.alpha = 1
            castedCell.orderCountStackView.alpha = 0
        }
        else {
            castedCell.addToCartButton.alpha = 0
            castedCell.orderCountStackView.alpha = 1
        }
        
        setupPriceLabel(castedCell, product)
        setupProgressView(castedCell, progress)
        
        castedCell.favoriteButton.tag = indexPath.item
        castedCell.addToCartButton.tag = indexPath.item
        castedCell.decrementButton.tag = indexPath.item
        castedCell.incrementButton.tag = indexPath.item
        castedCell.favoriteButton.addTarget(
            self,
            action: #selector(toggleFavoriteState),
            for: .touchUpInside
        )
        castedCell.addToCartButton.addTarget(
            self,
            action: #selector(addToCart),
            for: .touchUpInside
        )
        castedCell.decrementButton.addTarget(
            self,
            action: #selector(decrement),
            for: .touchUpInside
        )
        castedCell.incrementButton.addTarget(
            self,
            action: #selector(increment),
            for: .touchUpInside
        )
    }
}

extension ClosestOffersCollectionController {
    private func setupPriceLabel(_ castedCell: ClosestOfferCollectionCell, _ product: Product) {
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(
            string: product.name
        ))
        attributedText.append(NSAttributedString(
            string: " "
        ))
        attributedText.append(NSAttributedString(
            string: "\(product.price.priceFormatted) \(texts(.currency))",
            attributes: [
                NSAttributedString.Key.foregroundColor: colors(.lightAsset),
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.strikethroughColor: colors(.red)
            ]
        ))
        attributedText.append(NSAttributedString(
            string: "  "
        ))
        attributedText.append(NSAttributedString(
            string: "\(product.discountedPrice.priceFormatted) \(texts(.currency))",
            attributes: [
                NSAttributedString.Key.foregroundColor: colors(.green)
            ]
        ))
        
        castedCell.priceLabel.attributedText = attributedText
    }
    private func setupProgressView(_ castedCell: ClosestOfferCollectionCell, _ progress: CGFloat) {
        castedCell.progressView.widthConstraint.constant = progress * castedCell.progressPlaceholderView.bounds.width
        castedCell.progressView.layoutIfNeeded()
        castedCell.progressView.setCornerRadius(.half)
        castedCell.progressView.backgroundColor = color(ofProgress: progress)
    }
}
