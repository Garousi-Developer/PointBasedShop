import UIKit

extension UIView {
    func fadeIn(didComplete: (() -> Void)? = nil) {
        UIView.animate(withDuration: durations(.textField), animations: {
            self.alpha = 1
        })
        { _ in
            if let didComplete = didComplete {
                didComplete()
            }
        }
    }
    func fadeOut(didComplete: (() -> Void)? = nil) {
        UIView.animate(withDuration: durations(.textField), animations: {
            self.alpha = 0
        })
        { _ in
            if let didComplete = didComplete {
                didComplete()
            }
        }
    }
}
