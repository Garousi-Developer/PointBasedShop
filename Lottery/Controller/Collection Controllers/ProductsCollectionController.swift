import UIKit

class ProductsCollectionController: CollectionController {
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
        )) as! ProductCollectionCell
        
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
        )) as! ProductCollectionCell
        
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
        let firstSpacings: CGFloat = 3 * 18 + 2 * 12
        let secondSpacings: CGFloat = 4 * 6 + 3
        let constantHeights: CGFloat = 36
        let staticHeights: CGFloat = 120 + 40 + 35 + 5
        let dynamicHeights = 4 * fonts(.medium).firstLineHeight
        
        return constantHeights + scale * (firstSpacings + secondSpacings + staticHeights) + dynamicHeights
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        if isFirstTime {
            isFirstTime = false
            
            closestProducts = sharedData[index] as! [Product]
        }
        
        let castedCell = cell as! ProductCollectionCell
        let product = closestProducts[indexPath.item]
        let progress = Float(product.numberOfSoldProducts) / Float(product.numberOfProducts)
        
        castedCell.requiredPointsLabel.text = "\(product.requiredPoints) \(texts(.points))"
        castedCell.pictureImageView.image = product.picture
        castedCell.nameLabel.text = product.name
        castedCell.discountedPriceLabel.text = "\(product.discountedPrice.priceFormatted) \(texts(.currency))"
        castedCell.brandImageView.image = product.brandLogo
        castedCell.orderCountButton.setTitle("\(product.orderCount)", for: .normal)
        castedCell.numberOfSoldProductsLabel.text = "\(product.numberOfSoldProducts) \(texts(.number)) \(texts(.sold))"
        castedCell.progressView.setProgress(progress, animated: false)
        castedCell.progressView.progressTintColor = color(ofProgress: progress)
        castedCell.numberOfProductsLabel.text = "\(texts(.outOf)) \(product.numberOfProducts) \(texts(.number))"
        
        if product.isUnlocked {
            castedCell.lockStateButton.tintColor = colors(.green)
            castedCell.lockStateButton.setImage(#imageLiteral(resourceName: "unlocked"), for: .normal)
        }
        else {
            castedCell.lockStateButton.tintColor = colors(.highlightedAsset)
            castedCell.lockStateButton.setImage(#imageLiteral(resourceName: "locked"), for: .normal)
        }
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
        
        castedCell.favoriteButton.tag = indexPath.item
        castedCell.addToCartButton.tag = indexPath.item
        castedCell.decrementButton.tag = indexPath.item
        castedCell.incrementButton.tag = indexPath.item
        castedCell.favoriteButton.addTarget(self, action: #selector(toggleFavoriteState), for: .touchUpInside)
        castedCell.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        castedCell.decrementButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        castedCell.incrementButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
    }
}

extension ProductsCollectionController {
    private func setupPriceLabel(_ castedCell: ProductCollectionCell, _ product: Product) {
        castedCell.priceLabel.attributedText = NSAttributedString(
            string: "\(product.price.priceFormatted) \(texts(.currency))",
            attributes: [
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.strikethroughColor: colors(.red)
            ]
        )
    }
}
