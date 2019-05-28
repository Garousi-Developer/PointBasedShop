import UIKit

extension UIView {
    func fadeIn(didFinish: (() -> Void)? = nil) {
        UIView.animate(withDuration: durations(.textField), animations: {
            self.alpha = 1
        })
        { _ in
            if let didFinish = didFinish {
                didFinish()
            }
        }
    }
    func fadeOut(didFinish: (() -> Void)? = nil) {
        UIView.animate(withDuration: durations(.textField), animations: {
            self.alpha = 0
        })
        { _ in
            if let didFinish = didFinish {
                didFinish()
            }
        }
    }
}
