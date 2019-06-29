import UIKit

@IBDesignable
class StackView: UIStackView {
    @IBInspectable var firstShadowStyle: String! {
        didSet {
            setShadowStyle(ShadowStyle(rawValue: firstShadowStyle)!)
        }
    }
    @IBInspectable var firstBorderStyle: String! {
        didSet {
            setBorderStyle(BorderStyle(rawValue: firstBorderStyle)!)
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
            
        }
    }
    @IBInspectable var firstTintColor: String! {
        didSet {
            tintColor = colors(Color(rawValue: firstTintColor)!)
        }
    }
    @IBInspectable var firstIsRTL: Bool = true {
        didSet {
            semanticContentAttribute = firstIsRTL ? .forceRightToLeft : .forceLeftToRight
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
        if firstBackgroundColor != nil {
            let backgroundColorView = View(frame: bounds)
            backgroundColorView.backgroundColor = colors(Color(rawValue: firstBackgroundColor)!)
            insertSubview(backgroundColorView, at: 0)
        }
    }
}

extension StackView {
    private func setup() {
//        if let language = UserDefaults.standard.string(forKey: "language") {
//            switch language {
//            case "persian":
//                semanticContentAttribute = firstIsRTL ? .forceLeftToRight : .forceRightToLeft
//            case "english":
//                semanticContentAttribute = firstIsRTL ? .forceRightToLeft : .forceLeftToRight
//            default:
//                break
//            }
//        }
//        else {
//            semanticContentAttribute = firstIsRTL ? .forceLeftToRight : .forceRightToLeft
//        }
    }
}
