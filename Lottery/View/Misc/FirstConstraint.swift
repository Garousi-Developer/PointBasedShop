import UIKit

class FirstConstraint: NSLayoutConstraint {
    @IBInspectable var firstConstant: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        constant = firstConstant + scale * constant
    }
}
