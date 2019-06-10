import UIKit

class AwardsScrollController: ScrollController {
    override func didScroll() {
        super.didScroll()
        
        let castedViewController = viewController as! AwardsViewController
        let offset = scrollView.contentOffset.y
        
        if offset > 0 {
            castedViewController.shoppingCenterPictureImageView.transform = CGAffineTransform(translationX: 0, y: offset / 2)
            
            castedViewController.checkInView.layer.cornerRadius = 16 - offset / (scale * 8.25)
            castedViewController.checkInView.leadingConstraint.constant = scale * 12 - offset / 11
            castedViewController.checkInView.trailingConstraint.constant = scale * 12 - offset / 11
        }
        else {
            castedViewController.shoppingCenterPictureImageView.transform = CGAffineTransform(translationX: 0, y: 0)
            
            castedViewController.checkInView.layer.cornerRadius = 16
            castedViewController.checkInView.leadingConstraint.constant = scale * 12
            castedViewController.checkInView.trailingConstraint.constant = scale * 12
        }
    }
}
