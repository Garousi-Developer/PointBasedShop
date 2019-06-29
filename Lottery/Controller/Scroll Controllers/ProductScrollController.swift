import UIKit

class ProductScrollController: ScrollController {
    override func didScroll() {
        super.didScroll()
        
        let castedViewController = viewController as! ProductViewController
        let offset = scrollView.contentOffset.y
        let bottomViewY = castedViewController.bottomView.frame.origin.y
        
        if offset > 0 {
            castedViewController.collectionView.transform = CGAffineTransform(translationX: 0, y: offset / 2)
        }
        else {
            castedViewController.collectionView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
        if offset > bottomViewY {
            castedViewController.sectionsStackView.transform = CGAffineTransform(translationX: 0, y: offset - bottomViewY)
        }
        else {
            castedViewController.sectionsStackView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}
