import UIKit

class ContainersCollectionController: CollectionController {
    var containers: [Container] = []
    
    override func itemHeight() -> CGFloat {
        let spacings: CGFloat = 6
        let staticHeights: CGFloat = 60
        let dynamicHeights = fonts(.medium).firstLineHeight
        
        return scale * (spacings + staticHeights) + dynamicHeights
    }
    override func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        super.item(forCell: cell, atIndexPath: indexPath)
        
        containers = sharedData[index] as! [Container]
        
        let castedCell = cell as! ContainerCollectionCell
        let container = containers[indexPath.item]
        
        if index == 0 {
            castedCell.pictureImageView.setBorderStyle(.none)
            castedCell.pictureImageView.contentMode = .scaleAspectFill
            castedCell.pictureImageView.image = container.picture
        }
        else {
            castedCell.pictureImageView.setBorderStyle(.thick)
            castedCell.pictureImageView.contentMode = .scaleAspectFit
            castedCell.pictureImageView.image = container.logoPicture.withInsets(UIEdgeInsets(
                top: 16,
                left: 16,
                bottom: 16,
                right: 16
            ))
        }
        
        castedCell.titleLabel.text = container.name
    }
    override func itemDidSelect(atIndexPath indexPath: IndexPath) {
        super.itemDidSelect(atIndexPath: indexPath)
        
        viewController.navigateTo(
            .container,
            transferringData: containers[indexPath.item]
        )
    }
}
