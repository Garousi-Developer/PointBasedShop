import UIKit

class ContainersCollectionController: CollectionController {
    var cities: [NewCity] = []
    var shoppingCenters: [NewShoppingCenter] = []
    var brands: [NewBrand] = []
    
    override func itemHeight() -> CGFloat {
        let spacings: CGFloat = 6
        let staticHeights: CGFloat = 60
        let dynamicHeights = fonts(.medium).firstLineHeight
        
        return scale * (spacings + staticHeights) + dynamicHeights
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        let castedCell = cell as! ContainerCollectionCell
        
        switch data[0] {
        case is NewCity:
            cities = data as! [NewCity]
            let city = cities[indexPath.item]
            
            castedCell.pictureImageView.downloadImageFrom(city.pictureURL) { (image) in
                castedCell.pictureImageView.setBorderStyle(.none)
                castedCell.pictureImageView.contentMode = .scaleAspectFill
            }
            castedCell.titleLabel.text = languageIsPersian ? city.persianTitle : city.englishTitle
        case is NewShoppingCenter:
            shoppingCenters = data as! [NewShoppingCenter]
            let shoppingCenter = shoppingCenters[indexPath.item]
            
            castedCell.pictureImageView.downloadImageFrom(shoppingCenter.logoURL) { (image) in
                castedCell.pictureImageView.setBorderStyle(.thick)
                castedCell.pictureImageView.contentMode = .scaleAspectFit
                castedCell.pictureImageView.image = image.withInsets(UIEdgeInsets(
                    top: 16,
                    left: 16,
                    bottom: 16,
                    right: 16
                ))
            }
            castedCell.titleLabel.text = languageIsPersian ? shoppingCenter.persianTitle : shoppingCenter.englishTitle
        case is NewBrand:
            brands = data as! [NewBrand]
            let brand = brands[indexPath.item]
            
            castedCell.pictureImageView.downloadImageFrom(brand.logoURL) { (image) in
                castedCell.pictureImageView.setBorderStyle(.thick)
                castedCell.pictureImageView.contentMode = .scaleAspectFit
                castedCell.pictureImageView.image = castedCell.pictureImageView.image!.withInsets(UIEdgeInsets(
                    top: 16,
                    left: 16,
                    bottom: 16,
                    right: 16
                ))
            }
            castedCell.titleLabel.text = languageIsPersian ? brand.persianTitle : brand.englishTitle
        default:
            return
        }
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        let container: Container
        let containerId: Int
        switch data[0] {
        case is NewCity:
            let city = cities[indexPath.item]
            
            container = Container(
                type: .city,
                name: languageIsPersian ? city.persianTitle : city.englishTitle
            )
            containerId = city.id
        case is NewShoppingCenter:
            let shoppingCenter = shoppingCenters[indexPath.item]
            
            container = Container(
                type: .shoppingCenter,
                name: languageIsPersian ? shoppingCenter.persianTitle : shoppingCenter.englishTitle
            )
            containerId = shoppingCenter.id
        case is NewBrand:
            let brand = brands[indexPath.item]
            
            container = Container(
                type: .brand,
                name: languageIsPersian ? brand.persianTitle : brand.englishTitle
            )
            containerId = brand.id
        default:
            return
        }
        
        viewController.navigateTo(
            .container,
            transferringData: (container, containerId)
        )
    }
}
