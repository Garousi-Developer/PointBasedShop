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
            if backgroundColor == colors(.white) {
                if firstTintColorHolder == nil {
                    firstTintColorHolder = tintColor
                }
                
                tintColor = colors(.disabled)
            }
            else {
                if firstBackgroundColorHolder == nil {
                    firstBackgroundColorHolder = backgroundColor
                }
                
                backgroundColor = colors(.disabled)
            }
        }
    }
    fileprivate func enable() {
        if !isEnabled {
            if backgroundColor == colors(.white) {
                tintColor = firstTintColorHolder
            }
            else {
                backgroundColor = firstBackgroundColorHolder
            }
        }
    }
}
