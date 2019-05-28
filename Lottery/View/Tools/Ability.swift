import UIKit

extension UIButton {
    func disable(didFinish: (() -> Void)? = nil) {
        isEnabled = false
        
        UIView.animate(withDuration: durations(.interaction)) {
            
        }
    }
    func enable(didFinish: (() -> Void)? = nil) {
        
    }
}
