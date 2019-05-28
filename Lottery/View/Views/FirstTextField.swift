import UIKit
import PhoneNumberKit

@IBDesignable
class FirstTextField: TextField {
    @IBInspectable var focusedColor: String = Color.primary.rawValue
    
    var placeholderView: View!
    var placeholderLayer: TextLayer!
    var normalLine: ShapeLayer!
    var focusedLine: ShapeLayer!
    var errorLabel: Label!
    var isVerified = false
    
    private var isFirstDraw = true
    private var normalLineWidth: CGFloat = 1
    private var focusedLineWidth: CGFloat = 2
    private var animationDuration: TimeInterval = durations(.textField)
    private var phoneNumberKit: PhoneNumberKit!
    
    @objc override func textDidChange() {
        super.textDidChange()
        
        switch textContentType! {
        case .password:
            validatePassword()
        case .telephoneNumber:
            validateMobileNumber()
        default:
            break
        }
    }
    
    func showError(_ message: String) {
        isVerified = false
        
        errorLabel.text = message
        errorLabel.fadeIn()
    }
    func verify() {
        isVerified = true
        
        errorLabel.fadeOut()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isFirstDraw {
            isFirstDraw = false
            
            addPlaceholder()
            addNormalLine()
            addFocusedLine()
            addError()
        }
    }
    override func textFieldDidBeginEditing(_ textField: UITextField) {
        if text!.isEmpty {
            animatePlaceholderPosition()
            animatePlaceholderSize()
        }
        
        animatePlaceholderColor()
        firstSecurityToggleButton?.tintColor = colors(Color(rawValue: focusedColor)!)
        animateFocusedLine()
    }
    override func textFieldDidEndEditing(_ textField: UITextField) {
        if text!.isEmpty {
            animatePlaceholderPosition(isReversed: true)
            animatePlaceholderSize(isReversed: true)
        }
        
        animatePlaceholderColor(isReversed: true)
        firstSecurityToggleButton?.tintColor = colors(.asset)
        animateFocusedLine(isReversed: true)
    }
}

extension FirstTextField {
    private func setup() {
        if textContentType == .telephoneNumber {
            phoneNumberKit = PhoneNumberKit()
        }
    }
    
    private func addPlaceholder() {
        
    }
    private func addNormalLine() {
        
    }
    private func addFocusedLine() {
        
    }
    private func addError() {
        
    }
    
    private func animatePlaceholderPosition(isReversed: Bool = false) {
        
    }
    private func animatePlaceholderSize(isReversed: Bool = false) {
        
    }
    private func animatePlaceholderColor(isReversed: Bool = false) {
        
    }
    private func animateFocusedLine(isReversed: Bool = false) {
        
    }
    
    private func validateMobileNumber() {
        
    }
    private func validatePassword() {
        
    }
}
