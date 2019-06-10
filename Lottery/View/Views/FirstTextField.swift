import UIKit
import PhoneNumberKit
import SnapKit

@IBDesignable
class FirstTextField: TextField {
    @IBInspectable var firstFocusedColor: String = Color.primary.rawValue
    
    var placeholderView: View!
    var placeholderLayer: TextLayer!
    var normalLineLayer: ShapeLayer!
    var focusedLineLayer: ShapeLayer!
    var errorLabel: Label!
    var isVerified = false
    
    private var isFirstDraw = true
    private var normalLineWidth: CGFloat = 1
    private var focusedLineWidth: CGFloat = 2
    private var animationDuration: TimeInterval = durations(.textField)
    private var phoneNumberKit: PhoneNumberKit!
    
    @objc override func textDidChange() {
        super.textDidChange()
        
        switch textContentType {
        case UITextContentType.emailAddress:
            validateEmail()
        case UITextContentType.password:
            validatePassword()
        case UITextContentType.telephoneNumber:
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
        else {
            holdPlaceholderSize()
        }
        
        animatePlaceholderColor()
        firstSecurityToggleButton?.tintColor = colors(Color(rawValue: firstFocusedColor)!)
        animateFocusedLine()
    }
    override func textFieldDidEndEditing(_ textField: UITextField) {
        if text!.isEmpty {
            animatePlaceholderPosition(isReversed: true)
            animatePlaceholderSize(isReversed: true)
        }
        else {
            holdPlaceholderSize()
        }
        
        animatePlaceholderColor(isReversed: true)
        firstSecurityToggleButton?.tintColor = colors(.lightAsset)
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
        placeholderView = View(frame: bounds)
        placeholderView.isUserInteractionEnabled = false
        addSubview(placeholderView)
        
        placeholderLayer = TextLayer()
        placeholderLayer.frame = placeholderView.bounds
        placeholderLayer.string = attributedPlaceholder?.string
        placeholderLayer.foregroundColor = colors(.lightAsset).cgColor
        placeholderView.layer.addSublayer(placeholderLayer)
        
        attributedPlaceholder = nil
    }
    private func addNormalLine() {
        let path = UIBezierPath()
        path.move(to: CGPoint(
            x: layer.bounds.width,
            y: layer.bounds.height - normalLineWidth / 2
        ))
        path.addLine(to: CGPoint(
            x: 0,
            y: layer.bounds.height - normalLineWidth / 2
        ))
        
        normalLineLayer = ShapeLayer()
        normalLineLayer.path = path.cgPath
        normalLineLayer.lineCap = .round
        normalLineLayer.lineWidth = normalLineWidth
        normalLineLayer.strokeColor = colors(.line).cgColor
        layer.addSublayer(normalLineLayer)
    }
    private func addFocusedLine() {
        let path = UIBezierPath()
        path.move(to: CGPoint(
            x: layer.bounds.width,
            y: layer.bounds.height - focusedLineWidth / 2
        ))
        path.addLine(to: CGPoint(
            x: 0,
            y: layer.bounds.height - focusedLineWidth / 2
        ))
        
        focusedLineLayer = ShapeLayer()
        focusedLineLayer.path = path.cgPath
        focusedLineLayer.lineCap = .round
        focusedLineLayer.strokeEnd = 0
        focusedLineLayer.lineWidth = focusedLineWidth
        focusedLineLayer.strokeColor = colors(Color(rawValue: firstFocusedColor)!).cgColor
        layer.addSublayer(focusedLineLayer)
    }
    private func addError() {
        errorLabel = Label()
        errorLabel.alpha = 0
        errorLabel.textColor = colors(.red)
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(errorLabel.font.firstLineHeight + scale * 2 * 6)
        }
    }
    
    private func animatePlaceholderPosition(isReversed: Bool = false) {
        let translation = frame.height / 2 + fonts(.semiSmall).firstLineHeight / 2
        
        UIView.animate(withDuration: animationDuration) {
            if isReversed {
                self.placeholderView.center.y += translation
            }
            else {
                self.placeholderView.center.y -= translation
            }
        }
    }
    private func animatePlaceholderSize(isReversed: Bool = false) {
        if isReversed {
            let animation = BasicAnimation(keyPath: "fontSize")
            placeholderLayer.fontSize = fonts(.medium).pointSize
            animation.fromValue = fonts(.semiSmall).pointSize
            animation.duration = animationDuration
            
            placeholderLayer.add(animation, forKey: "reverseFontSize")
        }
        else {
            let animation = BasicAnimation(keyPath: "fontSize")
            placeholderLayer.fontSize = fonts(.semiSmall).pointSize
            animation.fromValue = fonts(.medium).pointSize
            animation.duration = animationDuration
            
            placeholderLayer.add(animation, forKey: "fontSize")
        }
    }
    private func animatePlaceholderColor(isReversed: Bool = false) {
        if isReversed {
            let animation = BasicAnimation(keyPath: "foregroundColor")
            placeholderLayer.foregroundColor = colors(.lightAsset).cgColor
            animation.fromValue = colors(Color(rawValue: firstFocusedColor)!).cgColor
            animation.duration = animationDuration
            
            placeholderLayer.add(animation, forKey: "reverseForegroundColor")
        }
        else {
            let animation = BasicAnimation(keyPath: "foregroundColor")
            placeholderLayer.foregroundColor = colors(Color(rawValue: firstFocusedColor)!).cgColor
            animation.fromValue = colors(.lightAsset).cgColor
            animation.duration = animationDuration
            
            placeholderLayer.add(animation, forKey: "foregroundColor")
        }
    }
    private func animateFocusedLine(isReversed: Bool = false) {
        if isReversed {
            let animation = BasicAnimation(keyPath: "strokeEnd")
            focusedLineLayer.strokeEnd = 0
            animation.fromValue = 1
            animation.duration = animationDuration
            
            focusedLineLayer.add(animation, forKey: "reverseStrokeEnd")
        }
        else {
            let animation = BasicAnimation(keyPath: "strokeEnd")
            focusedLineLayer.strokeEnd = 1
            animation.fromValue = 0
            animation.duration = animationDuration
            
            focusedLineLayer.add(animation, forKey: "strokeEnd")
        }
    }
    private func holdPlaceholderSize() {
        let animation = BasicAnimation(keyPath: "fontSize")
        placeholderLayer.fontSize = fonts(.semiSmall).pointSize
        animation.fromValue = fonts(.semiSmall).pointSize
        animation.duration = animationDuration
        
        placeholderLayer.add(animation, forKey: "fontSize")
    }
    
    private func validateEmail() {
        let emailRegex = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if text!.isEmpty {
            verify()
        }
        else {
            if emailPredicate.evaluate(with: text!) {
                verify()
            }
            else {
                showError(texts(.invalidEmail))
            }
        }
    }
    private func validateMobileNumber() {
        let parsedMobileNumber = try? phoneNumberKit.parse(text!)
        
        if let parsedMobileNumber = parsedMobileNumber, parsedMobileNumber.type == .mobile {
            verify()
        }
        else {
            showError(texts(.invalidMobileNumber))
        }
    }
    private func validatePassword() {
        if text!.count >= 4 {
            verify()
        }
        else {
            showError(texts(.shortPassword))
        }
    }
}
