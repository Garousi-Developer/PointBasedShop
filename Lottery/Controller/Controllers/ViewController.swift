import UIKit
import SVPinView

class ViewController: UIViewController {
    @IBInspectable var firstNavigationShadow: Bool = true
    @IBInspectable var firstKeyboardHandler: Bool = false
    @IBInspectable var firstPopup: Bool = false
    
    var tapRecognizer: UITapGestureRecognizer!
    var navigationShadowView: View!
    
    var isFirstLayout = true
    var keyboardFrameWillChange = false
    var keyboardEndY: CGFloat!
    var respondersSuperView: UIView!
    var buttons = false
    
    let refreshControl = RefreshControl()
    
    @objc func viewDidTap() {
        if firstPopup {
            let contentView = view.subviews[0] as! View
            let tappedPoint = tapRecognizer.location(in: view)
            
            if !contentView.frame.contains(tappedPoint) {
                navigateBack()
            }
        }
        else {
            view.endEditing(true)
        }
    }
    @objc func textDidBeginEditing(notification: Notification) {
        keyboardFrameWillChange = false
        
        delay(durations(.epsilon)) {
            guard !self.keyboardFrameWillChange else {
                self.keyboardFrameWillChange = false
                return
            }
            
            guard let scrollView = self.view.subviews[0] as? ScrollView else { return }
            var firstResponderSuperView: UIView
            if self.respondersSuperView != nil {
                firstResponderSuperView = self.respondersSuperView
            }
            else {
                firstResponderSuperView = scrollView.subviews[0]
            }
            let firstResponderOrNil = firstResponderSuperView.subviews.first { (subview) in
                return subview.isFirstResponder
            } as? UITextField
//            if notification.object is SVPinField {
//                firstResponderSuperView = (notification.object as! SVPinField).superview!
//                firstResponderOrNil = notification.object as! SVPinField
//            }
            guard let firstResponder = firstResponderOrNil, let keyboardEndY = self.keyboardEndY else { return }
            
            let additionalSpacePositives = keyboardEndY
            let additionalSpaceNegatives =
                firstResponderSuperView.convert(firstResponder.frame, to: self.view).maxY +
                fonts(.medium).firstLineHeight + scale * 2 * 6 + scale * 12
            let additionalSpace = additionalSpacePositives - additionalSpaceNegatives
            
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
        keyboardEndY = (notification.userInfo![UITextField.keyboardFrameEndUserInfoKey] as! CGRect).origin.y
        
        guard let scrollView = view.subviews[0] as? ScrollView else { return }
        let firstResponderSuperView: UIView
        if respondersSuperView != nil {
            firstResponderSuperView = respondersSuperView
        }
        else {
            firstResponderSuperView = scrollView.subviews[0]
        }
        let firstResponderOrNil = firstResponderSuperView.subviews.first { (subview) in
            return subview.isFirstResponder
        } as? TextField
        guard let firstResponder = firstResponderOrNil else { return }
        
        let additionalSpacePositives = keyboardEndY!
        let additionalSpaceNegatives =
            firstResponderSuperView.convert(firstResponder.frame, to: self.view).maxY +
            fonts(.medium).firstLineHeight + scale * 2 * 6 + scale * 12
        let additionalSpace = additionalSpacePositives - additionalSpaceNegatives
        
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
    @objc func refresh() {
        if refreshControl.requestHolder != nil {
            request(refreshControl.requestHolder)
        }
        else {
            for requestHolder in refreshControl.requestHolders {
                request(requestHolder)
            }
        }
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
        else if firstPopup {
            tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
            view.addGestureRecognizer(tapRecognizer)
        }
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
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
            navigationShadowView.layer.name = "navigationShadow"
            if firstNavigationShadow {
                navigationShadowView.setShadowStyle(.navigationBar)
            }
            navigationShadowView.backgroundColor = colors(.white)
            
            view.addSubview(navigationShadowView)
        }
    }
}
