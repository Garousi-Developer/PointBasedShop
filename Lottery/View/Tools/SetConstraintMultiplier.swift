import UIKit

extension NSLayoutConstraint {
    func withNewMultiplier(_ newMultiplier: CGFloat) -> FirstConstraint {
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = FirstConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: newMultiplier,
            constant: constant
        )
        newConstraint.identifier = identifier
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = shouldBeArchived
        
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
}
