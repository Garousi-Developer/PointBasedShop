import UIKit

extension Button {
    func disable(animated: Bool = true, didFinish: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: durations(.interaction)) {
                self.disable()
            }
        }
        else {
            disable()
        }
        
        isEnabled = false
    }
    func enable(animated: Bool = true, didFinish: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: animated ? durations(.interaction) : 0) {
                self.enable()
            }
        }
        else {
            enable()
        }
        
        isEnabled = true
    }
    
    fileprivate func disable() {
        if isEnabled {
            if backgroundColor != nil {
                if firstBackgroundColorHolder == nil {
                    firstBackgroundColorHolder = backgroundColor
                }
                
                backgroundColor = colors(.disabled)
            }
            else {
                if firstTintColorHolder == nil {
                    firstTintColorHolder = tintColor
                }
                
                tintColor = colors(.disabled)
            }
        }
    }
    fileprivate func enable() {
        if !isEnabled {
            if backgroundColor != nil {
                backgroundColor = firstBackgroundColorHolder
            }
            else {
                tintColor = firstTintColorHolder
            }
        }
    }
}
