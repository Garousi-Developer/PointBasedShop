import UIKit
import PhoneNumberKit

@IBDesignable
class TextField: PhoneNumberTextField {
    @IBInspectable var firstAutoEnableReturnKey: Bool = true {
        didSet {
            enablesReturnKeyAutomatically = firstAutoEnableReturnKey
        }
    }
    @IBInspectable var firstShadowStyle: String! {
        didSet {
            setShadowStyle(ShadowStyle(rawValue: firstShadowStyle)!)
        }
    }
    @IBInspectable var firstMaskedCorners: String! {
        didSet {
            layer.maskedCorners = maskedCornerses(MaskedCorners(rawValue: firstMaskedCorners)!)
        }
    }
    @IBInspectable var firstCornerRadius: String! {
        didSet {
            setCornerRadius(CornerRadius(rawValue: firstCornerRadius)!)
        }
    }
    @IBInspectable var firstBackgroundColor: String! {
        didSet {
            backgroundColor = colors(Color(rawValue: firstBackgroundColor)!)
        }
    }
    @IBInspectable var firstTintColor: String! {
        didSet {
            tintColor = colors(Color(rawValue: firstTintColor)!)
        }
    }
    @IBInspectable var firstPlaceholder: String! {
        didSet {
            let localizedPlaceholder = texts(Text(rawValue: firstPlaceholder)!)
            attributedPlaceholder = NSAttributedString(
                string: languageIsPersian ? localizedPlaceholder.persian : localizedPlaceholder.english,
                attributes: [NSAttributedString.Key.foregroundColor: colors(.lightAsset)]
            )
        }
    }
    @IBInspectable var firstSecureEntryIcon: UIImage! {
        didSet {
            setupSecurityToggleButton()
        }
    }
    @IBInspectable var firstInsecureEntryIcon: UIImage!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var firstSmartKeyboardType: UIKeyboardType {
        switch textContentType {
        case UITextContentType.emailAddress:
            return .emailAddress
        case UITextContentType.fullStreetAddress:
            return .default
        case UITextContentType.name, UITextContentType.givenName, UITextContentType.familyName:
            return .default
        case UITextContentType.password:
            return .asciiCapable
        case UITextContentType.telephoneNumber:
            return .asciiCapableNumberPad
        default:
            return .asciiCapableNumberPad
        }
    }
    var firstCommonMobileNumber: String! {
        guard textContentType == .telephoneNumber else {
            return nil
        }
        
        return "0" + nationalNumber
    }
    var firstSecurityToggleButton: Button!
    var firstIsFirstLayout = true
    
    @objc func textDidChange() {
        if textContentType == .telephoneNumber || textContentType == .emailAddress {
            text = text!.trimmingCharacters(in: [" "])
        }
    }
    @objc func firstToggleSecurity() {
        isSecureTextEntry.toggle()
        
        if isSecureTextEntry {
            firstSecurityToggleButton.firstImageAfterInteractionAnimation = firstSecureEntryIcon
        }
        else {
            firstSecurityToggleButton.firstImageAfterInteractionAnimation = firstInsecureEntryIcon
        }
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
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if firstIsFirstLayout {
            firstIsFirstLayout = false
            
            if let firstCornerRadius = firstCornerRadius {
                setCornerRadius(CornerRadius(rawValue: firstCornerRadius)!)
            }
        }
    }
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if returnKeyType == .next {
            let nextTextField = superview!.viewWithTag(tag + 1) as! TextField
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
}

extension TextField {
    private func setup() {
        keyboardType = firstSmartKeyboardType
        enablesReturnKeyAutomatically = firstAutoEnableReturnKey
        borderStyle = .none
        tintColor = colors(.primary)
        textAlignment = languageIsPersian ? textAlignments(.right) : textAlignments(.left)
        font = fonts(.medium)
        minimumFontSize = fonts(.small).pointSize
        textColor = colors(.darkAsset)
        
        if textContentType == .password {
            isSecureTextEntry = true
        }
        if textContentType != .telephoneNumber {
            isPartialFormatterEnabled = false
        }
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    private func setupSecurityToggleButton() {
        firstSecurityToggleButton = Button(type: .custom)
        firstSecurityToggleButton.frame.size.width = 24
        firstSecurityToggleButton.frame.size.height = 24
        firstSecurityToggleButton.setCornerRadius(.half)
        firstSecurityToggleButton.tintColor = colors(.lightAsset)
        firstSecurityToggleButton.setImage(firstSecureEntryIcon, for: .normal)
        firstSecurityToggleButton.firstInteractionAnimationType = .glow
        firstSecurityToggleButton.addTarget(self, action: #selector(firstToggleSecurity), for: .touchDown)
        
        if languageIsPersian {
            leftViewMode = .always
            leftView = firstSecurityToggleButton
        }
        else {
            rightViewMode = .always
            rightView = firstSecurityToggleButton
        }
    }
}
