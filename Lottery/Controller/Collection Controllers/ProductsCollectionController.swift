import UIKit

class ProductsCollectionController: CollectionController {
    var products: [NewProduct] = []
    
    @objc func toggleFavoriteState(sender: Button) {
//        products[sender.tag].isFavorite.toggle()
//
//        delay(durations(.interaction)) {
//            self.collectionView.reloadItems(at: [IndexPath(
//                item: sender.tag,
//                section: 0
//            )])
//
//            if self.products[sender.tag].isFavorite {
//                sender.tintColor = colors(.red)
//            }
//            else {
//                sender.tintColor = colors(.asset)
//            }
//        }
    }
    @objc func remove(sender: Button) {
//        let cartViewController = viewController as! CartViewController
        let product = products[sender.tag]
        
        product.orderCount = 0
        data.remove(at: sender.tag)
        cart.remove(at: sender.tag)
        
//        if cart.isEmpty {
//            cartViewController.addressView.fadeOut()
//        }
    }
    @objc func addToCart(sender: Button) {
        let cell = collectionView.cellForItem(at: IndexPath(
            item: sender.tag,
            section: 0
        )) as! ProductCollectionCell
        let product = products[sender.tag]
        
        // Refer cart to products.
        product.orderCount += 1
//        cart.append(product)
        
        delay(durations(.interaction)) {
            cell.addToCartButton.fadeOut()
            cell.orderCountStackView.fadeIn()
            
            delay(durations(.textField)) {
                self.collectionView.reloadData()
            }
        }
    }
    @objc func decrement(sender: Button) {
        let cell = collectionView.cellForItem(at: IndexPath(
            item: sender.tag,
            section: 0
        )) as! ProductCollectionCell
        let product = products[sender.tag]
//        let cartProductIndex = cart.firstIndex { (cartProduct) in
//            return cartProduct.name == product.persianTitle
//        }!
        
        product.orderCount -= 1
        
        delay(durations(.interaction)) {
            if product.orderCount == 0 {
                if self.viewController is CartViewController {
                    self.remove(sender: Button())
                }
                else {
//                    cart.remove(at: cartProductIndex)
                    
                    cell.orderCountStackView.fadeOut()
                    cell.addToCartButton.fadeIn()
                    
                    delay(durations(.textField)) {
                        self.collectionView.reloadData()
                    }
                }
            }
            else {
                delay(durations(.interaction)) {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    @objc func increment(sender: Button) {
        let product = products[sender.tag]
        
        product.orderCount += 1
        
        delay(2 * durations(.interaction)) {
            self.collectionView.reloadData()
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
        
        products = data as! [NewProduct]
        let castedCell = cell as! ProductCollectionCell
        let product = products[indexPath.item]
        let progress = Float(product.soldCount) / Float(product.count)
        let cartProduct = cart.first { (cartProduct) in
            return cartProduct.id == product.id
        }
        if let cartProduct = cartProduct {
            product.orderCount = cartProduct.orderCount
        }
        
        castedCell.requiredPointsLabel.text = "\(product.requiredPoints) \(texts(.points))"
        castedCell.pictureImageView.downloadImageFrom(product.pictureURL)
        castedCell.nameLabel.text = product.persianTitle
        castedCell.discountedPriceLabel.text = "\(Int(product.discountedPrice).priceFormatted) \(texts(.currency))"
        castedCell.brandLogoImageView.downloadImageFrom(product.brand.logoURL)
        castedCell.brandNameLabel.text = product.brand.persianTitle
        castedCell.orderCountButton.setTitle("\(product.orderCount)", for: .normal)
        castedCell.numberOfSoldProductsLabel.text = "\(product.soldCount) \(texts(.number)) \(texts(.sold))"
        castedCell.progressView.setProgress(progress, animated: false)
        castedCell.progressView.progressTintColor = color(ofProgress: progress)
        castedCell.numberOfProductsLabel.text = "\(texts(.outOf)) \(product.count) \(texts(.number))"
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            if product.isLocked {
                castedCell.lockStateButton.tintColor = colors(.highlightedAsset)
                castedCell.lockStateButton.setImage(#imageLiteral(resourceName: "locked"), for: .normal)
            }
            else {
                castedCell.lockStateButton.tintColor = colors(.green)
                castedCell.lockStateButton.setImage(#imageLiteral(resourceName: "unlocked"), for: .normal)
            }
            if product.isFavorite {
                castedCell.favoriteButton.tintColor = colors(.red)
            }
            else {
                castedCell.favoriteButton.tintColor = colors(.asset)
            }
        }
        if product.orderCount == 0 {
            castedCell.addToCartButton.alpha = 1
            castedCell.orderCountStackView.alpha = 0
            castedCell.orderCountButton.setTitle("1", for: .normal)
        }
        else {
            castedCell.addToCartButton.alpha = 0
            castedCell.orderCountStackView.alpha = 1
        }
        
        setupPriceLabel(castedCell, product)
        
        castedCell.favoriteButton.tag = indexPath.item
        castedCell.removeButton?.tag = indexPath.item
        castedCell.addToCartButton.tag = indexPath.item
        castedCell.decrementButton.tag = indexPath.item
        castedCell.incrementButton.tag = indexPath.item
        castedCell.favoriteButton.addTarget(self, action: #selector(toggleFavoriteState), for: .touchUpInside)
        castedCell.removeButton?.addTarget(self, action: #selector(remove), for: .touchUpInside)
        castedCell.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        castedCell.decrementButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        castedCell.incrementButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        if !(viewController is ProductViewController) {
            viewController.navigateTo(
                .product,
                transferringData: products[indexPath.item]
            )
        }
    }
}

extension ProductsCollectionController {
    private func setupPriceLabel(_ castedCell: ProductCollectionCell, _ product: NewProduct) {
        castedCell.priceLabel.attributedText = NSAttributedString(
            string: "\(product.price.priceFormatted) \(texts(.currency))",
            attributes: [
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.strikethroughColor: colors(.red)
            ]
        )
    }
}
