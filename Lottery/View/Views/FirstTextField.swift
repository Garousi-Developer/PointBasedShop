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
        firstSecurityToggleButton?.tintColor = colors(Color(rawValue: firstFocusedColor)!)
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
        let animation = BasicAnimation(keyPath: "fontSize")
        if isReversed {
            animation.fromValue = fonts(.semiSmall).pointSize
            placeholderLayer.fontSize = fonts(.medium).pointSize
        }
        else {
            animation.fromValue = fonts(.medium).pointSize
            placeholderLayer.fontSize = fonts(.semiSmall).pointSize
        }
        animation.duration = animationDuration
        
        placeholderLayer.add(animation, forKey: "fontSize")
    }
    private func animatePlaceholderColor(isReversed: Bool = false) {
        let animation = BasicAnimation(keyPath: "foregroundColor")
        if isReversed {
            animation.fromValue = colors(Color(rawValue: firstFocusedColor)!).cgColor
            placeholderLayer.foregroundColor = colors(.lightAsset).cgColor
        }
        else {
            animation.fromValue = colors(.lightAsset).cgColor
            placeholderLayer.foregroundColor = colors(Color(rawValue: firstFocusedColor)!).cgColor
        }
        animation.duration = animationDuration
        
        placeholderLayer.add(animation, forKey: "foregroundColor")
    }
    private func animateFocusedLine(isReversed: Bool = false) {
        let animation = BasicAnimation(keyPath: "strokeEnd")
        if isReversed {
            animation.fromValue = 1
            focusedLineLayer.strokeEnd = 0
        }
        else {
            animation.fromValue = 0
            focusedLineLayer.strokeEnd = 1
        }
        animation.duration = animationDuration
        
        focusedLineLayer.add(animation, forKey: "strokeEnd")
    }
    
    private func validateMobileNumber() {
        
    }
    private func validatePassword() {
        
    }
}
