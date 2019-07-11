import UIKit

class ProfileSettingsScrollController: ScrollController {
    override func didScroll() {
        super.didScroll()
        
        let castedViewController = viewController as! ProfileSettingsViewController
        let offset = scrollView.contentOffset.y
        
        if offset > 0 {
            castedViewController.sectionsStackView.transform = CGAffineTransform(translationX: 0, y: offset)
        }
        else {
            castedViewController.sectionsStackView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}
