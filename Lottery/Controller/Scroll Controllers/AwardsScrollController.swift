import UIKit

class AwardsScrollController: ScrollController {
    override func didScroll() {
        super.didScroll()
        
        let castedViewController = viewController as! ProfileViewController
        let offset = scrollView.contentOffset.y
        
        if offset > 0 {
            castedViewController.shoppingCenterPictureImageView.transform = CGAffineTransform(translationX: 0, y: offset / 2)
        }
        else {
            castedViewController.shoppingCenterPictureImageView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}
