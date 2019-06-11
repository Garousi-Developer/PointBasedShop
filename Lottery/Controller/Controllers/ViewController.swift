import UIKit

class ViewController: UIViewController {
    @IBInspectable var firstNavigationShadow: Bool = true
    @IBInspectable var firstKeyboardHandler: Bool = false
    
    var tapRecognizer: UITapGestureRecognizer!
    var navigationShadowView: View!
    
    var isFirstLayout = true
    var keyboardFrameWillChange = false
    var keyboardEndY: CGFloat!
    
    @objc func viewDidTap() {
        view.endEditing(true)
    }
    @objc func textDidBeginEditing() {
        keyboardFrameWillChange = false
        
        delay(durations(.epsilon)) {
            guard !self.keyboardFrameWillChange else {
                self.keyboardFrameWillChange = false
                return
            }
            
            let firstResponderOrNil = self.view.subviews.first { (subview) in
                return subview.isFirstResponder
            } as? TextField
            guard let firstResponder = firstResponderOrNil, let keyboardEndY = self.keyboardEndY else { return }
            
            let additionalSpace = keyboardEndY - (firstResponder.frame.maxY + 16)
            
            UIView.animate(withDuration: durations(.interaction), animations: {
                if additionalSpace < 0 {
                    self.view.frame.origin.y = additionalSpace
                    self.navigationShadowView?.frame.origin.y = UIApplication.shared.statusBarFrame.origin.y - additionalSpace
                }
                else {
                    self.view.frame.origin.y = 0
                    self.navigationShadowView?.frame.origin.y = UIApplication.shared.statusBarFrame.origin.y
                }
            })
        }
    }
    @objc func keyboardWillChangeFrame(notification: Notification) {
        keyboardFrameWillChange = true
        
        let firstResponderOrNil = view.subviews.first { (subview) in
            return subview.isFirstResponder
        } as? TextField
        guard let firstResponder = firstResponderOrNil else { return }
        
        keyboardEndY = (notification.userInfo![UITextField.keyboardFrameEndUserInfoKey] as! CGRect).origin.y
        let additionalSpace = keyboardEndY - (firstResponder.frame.maxY + 16)
        
        UIView.animate(withDuration: durations(.interaction), animations: {
            if additionalSpace < 0 {
                self.view.frame.origin.y = additionalSpace
                self.navigationShadowView?.frame.origin.y = UIApplication.shared.statusBarFrame.origin.y - additionalSpace
            }
            else {
                self.view.frame.origin.y = 0
                self.navigationShadowView?.frame.origin.y = UIApplication.shared.statusBarFrame.origin.y
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if firstKeyboardHandler {
            tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
            view.addGestureRecognizer(tapRecognizer)
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(textDidBeginEditing),
                name: UITextField.textDidBeginEditingNotification,
                object: nil
            )
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillChangeFrame),
                name: UITextField.keyboardWillChangeFrameNotification,
                object: nil
            )
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if isFirstLayout {
            isFirstLayout = false
            addNavigationShadowView()
        }
    }
}

extension ViewController {
    private func addNavigationShadowView() {
        if let navigationController = navigationController {
            navigationShadowView = View(frame: CGRect(
                x: UIApplication.shared.statusBarFrame.origin.x,
                y: UIApplication.shared.statusBarFrame.origin.y,
                width: UIApplication.shared.statusBarFrame.width,
                height: UIApplication.shared.statusBarFrame.height + navigationController.navigationBar.frame.height
            ))
            if firstNavigationShadow {
                navigationShadowView.setShadowStyle(.navigationBar)
            }
            navigationShadowView.backgroundColor = colors(.white)
            
            view.addSubview(navigationShadowView)
        }
    }
}
