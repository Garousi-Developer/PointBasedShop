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
        }
    }
}
