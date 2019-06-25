import UIKit

class ProductsCollectionController: CollectionController {
    var products: [NewProduct] = []
    var addFavoriteParameters: AddFavoriteParameters!
    var removeFavoriteParameters: RemoveFavoriteParameters!
    var updateCartParameters: UpdateCartParameters!
    var responseController: ResponseController!
    
    @objc func toggleFavoriteState(sender: Button) {
        if UserDefaults.standard.string(forKey: "token") != nil {
            let product = products[sender.tag]
            if product.isFavorite {
                removeFavoriteParameters = RemoveFavoriteParameters(productIds: [product.id])
                responseController = ResponseController(viewController: viewController)
                responseController.requestHolder = request(RequestHolder(
                    endPointName: .removeFavorite(parameters: removeFavoriteParameters),
                    didSucceed: responseController.didSucceed,
                    didFail: responseController.didFail,
                    blocking: false
                ))
            }
            else {
                addFavoriteParameters = AddFavoriteParameters(productId: product.id)
                responseController = ResponseController(viewController: viewController)
                responseController.requestHolder = request(RequestHolder(
                    endPointName: .addFavorite(parameters: addFavoriteParameters),
                    didSucceed: responseController.didSucceed,
                    didFail: responseController.didFail,
                    blocking: false
                ))
            }
            
            if viewController is FavoritesViewController {
                let favoritesViewController = viewController as! FavoritesViewController
                delay(durations(.interaction)) {
                    let dataProductIndex = (self.data as! [NewProduct]).firstIndex(where: { (dataProduct: NewProduct) in
                        dataProduct.id == product.id
                    })!
                    self.data.remove(at: dataProductIndex)
                    if self.data.isEmpty {
                        favoritesViewController.removeAllButton.fadeOut()
                        favoritesViewController.addAllToCartButton.fadeOut()
                    }
                }
            }
            else {
                product.isFavorite.toggle()
                delay(durations(.interaction)) {
                    if self.products[sender.tag].isFavorite {
                        sender.tintColor = colors(.red)
                    }
                    else {
                        sender.tintColor = colors(.asset)
                    }
                }
            }
        }
    }
    @objc func remove(sender: Button) {
        let product = products[sender.tag]
        responseController = ResponseController(viewController: viewController)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .removeCart(id: product.id),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: false
        ))
        
        let cartViewController = viewController as! CartViewController
        delay(durations(.interaction)) {
            let dataProductIndex = (self.data as! [NewProduct]).firstIndex(where: { (dataProduct: NewProduct) in
                dataProduct.id == product.id
            })!
            self.data.remove(at: dataProductIndex)
            cartViewController.setProductsHeight(animated: true)
            if self.data.isEmpty {
                cartViewController.finalizeButton.fadeOut()
            }
        }
    }
    @objc func addToCart(sender: Button) {
        if UserDefaults.standard.string(forKey: "token") != nil {
            let product = products[sender.tag]
            updateCartParameters = UpdateCartParameters(productIds: [product.id], updateType: "increment")
            responseController = ResponseController(viewController: viewController)
            responseController.requestHolder = request(RequestHolder(
                endPointName: .updateCart(parameters: updateCartParameters),
                didSucceed: responseController.didSucceed,
                didFail: responseController.didFail,
                blocking: false
            ))
            
            product.orderCount += 1
            let cell = collectionView.cellForItem(at: IndexPath(
                item: sender.tag,
                section: 0
            )) as! ProductCollectionCell
            cell.orderCountButton.setTitle("\(product.orderCount ?? 0)", for: .normal)
            delay(durations(.interaction)) {
                cell.addToCartButton.fadeOut()
                cell.orderCountStackView.fadeIn()
            }
        }
    }
    @objc func decrement(sender: Button) {
        let product = products[sender.tag]
        updateCartParameters = UpdateCartParameters(productIds: [product.id], updateType: "decrement")
        responseController = ResponseController(viewController: viewController)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .updateCart(parameters: updateCartParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: false
        ))
        
        let dataProductIndex = (data as! [NewProduct]).firstIndex(where: { (dataProduct: NewProduct) in
            dataProduct.id == product.id
        })!
        product.orderCount -= 1
        let cell = collectionView.cellForItem(at: IndexPath(
            item: dataProductIndex,
            section: 0
        )) as! ProductCollectionCell
        if product.orderCount == 0 {
            delay(durations(.interaction)) {
                if self.viewController is CartViewController {
                    let cartViewController = self.viewController as! CartViewController
                    delay(durations(.interaction)) {
                        self.data.remove(at: dataProductIndex)
                        cartViewController.setProductsHeight(animated: true)
                        if self.data.isEmpty {
                            cartViewController.finalizeButton.fadeOut()
                        }
                    }
                }
                else {
                    cell.orderCountStackView.fadeOut()
                    cell.addToCartButton.fadeIn()
                }
            }
        }
        else {
            cell.orderCountButton.setTitle("\(product.orderCount ?? 0)", for: .normal)
        }
    }
    @objc func increment(sender: Button) {
        let product = products[sender.tag]
        updateCartParameters = UpdateCartParameters(productIds: [product.id], updateType: "increment")
        responseController = ResponseController(viewController: viewController)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .updateCart(parameters: updateCartParameters),
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: false
        ))
        
        product.orderCount += 1
        let cell = collectionView.cellForItem(at: IndexPath(
            item: sender.tag,
            section: 0
        )) as! ProductCollectionCell
        cell.orderCountButton.setTitle("\(product.orderCount ?? 0)", for: .normal)
    }
    
    override func itemHeight() -> CGFloat {
        let firstSpacings: CGFloat
        if viewController is ProductViewController {
            firstSpacings = 2 * 18 + 2 * 12 + 6
        }
        else {
            firstSpacings = 3 * 18 + 2 * 12
        }
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
        
        castedCell.requiredPointsLabel.text = "\(product.requiredPoints.priceFormatted) \(texts(.points))"
        castedCell.pictureImageView.downloadImageFrom(product.pictureURL)
        castedCell.nameLabel.text = product.persianTitle
        castedCell.discountedPriceLabel.text = "\(Int(product.discountedPrice).priceFormatted) \(texts(.currency))"
        castedCell.brandLogoImageView.downloadImageFrom(product.brand.logoURL)
        castedCell.brandNameLabel.text = product.brand.persianTitle
        castedCell.orderCountButton.setTitle("\(product.orderCount ?? 0)", for: .normal)
        castedCell.numberOfSoldProductsLabel.text = "\(product.soldCount.priceFormatted) \(texts(.number)) \(texts(.sold))"
        castedCell.progressView.setProgress(progress, animated: false)
        castedCell.progressView.progressTintColor = color(ofProgress: progress)
        castedCell.numberOfProductsLabel.text = "\(texts(.outOf)) \(product.count.priceFormatted) \(texts(.number))"
        
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
            if product.orderCount == 0 {
                castedCell.addToCartButton.alpha = 1
                castedCell.orderCountStackView.alpha = 0
            }
            else {
                castedCell.addToCartButton.alpha = 0
                castedCell.orderCountStackView.alpha = 1
            }
        }
        
        setupPriceLabel(castedCell, product)
        
        castedCell.favoriteButton.tag = indexPath.item
        castedCell.removeButton?.tag = indexPath.item
        castedCell.addToCartButton.tag = indexPath.item
        castedCell.decrementButton.tag = indexPath.item
        castedCell.incrementButton.tag = indexPath.item
        
        castedCell.favoriteButton.removeTarget(nil, action: nil, for: .touchUpInside)
        castedCell.favoriteButton.addDefaultTapTarget()
        castedCell.favoriteButton.addTarget(self, action: #selector(toggleFavoriteState), for: .touchUpInside)
        
        castedCell.removeButton?.removeTarget(nil, action: nil, for: .touchUpInside)
        castedCell.removeButton?.addDefaultTapTarget()
        castedCell.removeButton?.addTarget(self, action: #selector(remove), for: .touchUpInside)
        
        castedCell.addToCartButton.removeTarget(nil, action: nil, for: .touchUpInside)
        castedCell.addToCartButton.addDefaultTapTarget()
        castedCell.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        
        castedCell.decrementButton.removeTarget(nil, action: nil, for: .touchUpInside)
        castedCell.decrementButton.addDefaultTapTarget()
        castedCell.decrementButton.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        
        castedCell.incrementButton.removeTarget(nil, action: nil, for: .touchUpInside)
        castedCell.incrementButton.addDefaultTapTarget()
        castedCell.incrementButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        let product = products[indexPath.item]
        if !(viewController is ProductViewController) {
            viewController.navigateTo(
                .product,
                transferringData: (product.persianTitle, product.id)
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
