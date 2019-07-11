import UIKit

class ClaimPointsScrollController: ScrollController {
    override func didScroll() {
        super.didScroll()
        
        let castedViewController = viewController as! ClaimPointsViewController
        let offset = scrollView.contentOffset.y
        
        if offset > 0 {
            castedViewController.shoppingCenterPictureImageView.transform = CGAffineTransform(translationX: 0, y: offset / 2)
            
            castedViewController.submitView.layer.cornerRadius = 16 - offset / (scale * 8.25)
            castedViewController.submitView.leadingConstraint.constant = scale * 12 - offset / 11
            castedViewController.submitView.trailingConstraint.constant = scale * 12 - offset / 11
            
            castedViewController.descriptionLabel.leadingConstraint.constant = scale * 12 + offset / 11
            castedViewController.descriptionLabel.trailingConstraint.constant = scale * 12 + offset / 11
            
            castedViewController.purchaseAmountTextField.leadingConstraint.constant = scale * 12 + offset / 11
            castedViewController.purchaseAmountTextField.trailingConstraint.constant = scale * 12 + offset / 11
            
            castedViewController.employeeIdTextField.leadingConstraint.constant = scale * 12 + offset / 11
            castedViewController.employeeIdTextField.trailingConstraint.constant = scale * 12 + offset / 11
            
            castedViewController.secretTokenLabel.trailingConstraint.constant = scale * 12 + offset / 11
            castedViewController.pinView.leadingConstraint.constant = scale * 12 + offset / 11
        }
        else {
            castedViewController.shoppingCenterPictureImageView.transform = CGAffineTransform(translationX: 0, y: 0)
            
            castedViewController.submitView.layer.cornerRadius = 16
            castedViewController.submitView.leadingConstraint.constant = scale * 12
            castedViewController.submitView.trailingConstraint.constant = scale * 12
            
            castedViewController.descriptionLabel.leadingConstraint.constant = scale * 12
            castedViewController.descriptionLabel.trailingConstraint.constant = scale * 12
            
            castedViewController.purchaseAmountTextField.leadingConstraint.constant = scale * 12
            castedViewController.purchaseAmountTextField.trailingConstraint.constant = scale * 12
            
            castedViewController.employeeIdTextField.leadingConstraint.constant = scale * 12
            castedViewController.employeeIdTextField.trailingConstraint.constant = scale * 12
            
            castedViewController.secretTokenLabel.trailingConstraint.constant = scale * 12
            castedViewController.pinView.leadingConstraint.constant = scale * 12
        }
    }
}
