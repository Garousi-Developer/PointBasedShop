import UIKit

class ContainerScrollController: ScrollController {
    override func didScroll() {
        super.didScroll()
        
        let castedViewController = viewController as! ContainerViewController
        let offset = scrollView.contentOffset.y
        
        if offset > 0 {
            castedViewController.pictureImageView.transform = CGAffineTransform(translationX: 0, y: offset / 2)
            
            castedViewController.descriptionView.layer.cornerRadius = 16 - offset / (scale * 8.25)
            castedViewController.descriptionView.leadingConstraint.constant = scale * 12 - offset / 11
            castedViewController.descriptionView.trailingConstraint.constant = scale * 12 - offset / 11
            
            castedViewController.containerNameLabel.leadingConstraint.constant = scale * 12 + offset / 11
            castedViewController.containerNameLabel.trailingConstraint.constant = scale * 12 + offset / 11
            
            castedViewController.descriptionLabel.leadingConstraint.constant = scale * 12 + offset / 11
            castedViewController.descriptionLabel.trailingConstraint.constant = scale * 12 + offset / 11
            
            if castedViewController.container.type != .brand {
                castedViewController.topContentsLabel.leadingConstraint.constant = offset / 11
                castedViewController.topContentsLabel.trailingConstraint.constant = offset / 11
            }
            
            if castedViewController.container.type != .brand {
                castedViewController.topContentsCollectionView.leadingConstraint.constant = scale * -12 + offset / 11
                castedViewController.topContentsCollectionView.trailingConstraint.constant = scale * -12 + offset / 11
            }
            
            castedViewController.mapImageView.leadingConstraint.constant = offset / 11
            castedViewController.mapImageView.trailingConstraint.constant = offset / 11
            
            if castedViewController.container.type != .brand && castedViewController.hottestOffersLabel != nil {
                castedViewController.hottestOffersLabel.trailingConstraint.constant = offset / 11
                castedViewController.moreButton.leadingConstraint.constant = offset / 11
            }
            
            if castedViewController.container.type != .brand && castedViewController.hottestOffersLabel != nil {
                castedViewController.hottestOffersCollectionView.leadingConstraint.constant = scale * -12 + offset / 11
                castedViewController.hottestOffersCollectionView.trailingConstraint.constant = scale * -12 + offset / 11
            }
            
            castedViewController.adImageView.leadingConstraint.constant = offset / 11
            castedViewController.adImageView.trailingConstraint.constant = offset / 11
        }
        else {
            castedViewController.pictureImageView.transform = CGAffineTransform(translationX: 0, y: 0)
            
            castedViewController.descriptionView.layer.cornerRadius = 16
            castedViewController.descriptionView.leadingConstraint.constant = scale * 12
            castedViewController.descriptionView.trailingConstraint.constant = scale * 12
            
            castedViewController.containerNameLabel.leadingConstraint.constant = scale * 12
            castedViewController.containerNameLabel.trailingConstraint.constant = scale * 12
            
            castedViewController.descriptionLabel.leadingConstraint.constant = scale * 12
            castedViewController.descriptionLabel.trailingConstraint.constant = scale * 12
            
            if castedViewController.container.type != .brand {
                castedViewController.topContentsLabel.leadingConstraint.constant = 0
                castedViewController.topContentsLabel.trailingConstraint.constant = 0
            }
            
            if castedViewController.container.type != .brand {
                castedViewController.topContentsCollectionView.leadingConstraint.constant = scale * -12
                castedViewController.topContentsCollectionView.trailingConstraint.constant = scale * -12
            }
            
            castedViewController.mapImageView.leadingConstraint.constant = 0
            castedViewController.mapImageView.trailingConstraint.constant = 0
            
            if castedViewController.container.type != .brand && castedViewController.hottestOffersLabel != nil {
                castedViewController.hottestOffersLabel.trailingConstraint.constant = 0
                castedViewController.moreButton.leadingConstraint.constant = 0
            }
            
            if castedViewController.container.type != .brand && castedViewController.hottestOffersLabel != nil {
                castedViewController.hottestOffersCollectionView.leadingConstraint.constant = scale * -12
                castedViewController.hottestOffersCollectionView.trailingConstraint.constant = scale * -12
            }
            
            castedViewController.adImageView.leadingConstraint.constant = 0
            castedViewController.adImageView.trailingConstraint.constant = 0
        }
    }
}
