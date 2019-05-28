import UIKit

@IBDesignable
class Label: UILabel {
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
            backgroundColor = colors(Color(rawValue: firstBackgroundColor)!)
        }
    }
    @IBInspectable var firstTintColor: String! {
        didSet {
            tintColor = colors(Color(rawValue: firstTintColor)!)
        }
    }
    @IBInspectable var firstNumberOfLines: Int = 0 {
        didSet {
            numberOfLines = firstNumberOfLines
        }
    }
    @IBInspectable var firstTextAlignment: String = TextAlignment.right.rawValue {
        didSet {
            textAlignment = textAlignments(TextAlignment(rawValue: firstTextAlignment)!)
        }
    }
    @IBInspectable var firstFont: String = Font.medium.rawValue {
        didSet {
            font = fonts(Font(rawValue: firstFont)!)
        }
    }
    @IBInspectable var firstTextColor: String = Color.asset.rawValue {
        didSet {
            textColor = colors(Color(rawValue: firstTextColor)!)
        }
    }
    @IBInspectable var firstText: String = Text.empty.rawValue {
        didSet {
            text = texts(Text(rawValue: firstText)!)
        }
    }
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var firstRealNumberOfLines: Int {
        let maxSize = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        let firstNumberOfLines = lround(Double(textHeight / lineHeight))
        
        return firstNumberOfLines
    }
    var firstIsFirstLayout = true
    
    override var text: String? {
        didSet {
            if firstRealNumberOfLines > 1 {
                setLineSpacing()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
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
}

extension Label {
    private func setup() {
        clipsToBounds = true
        
        numberOfLines = firstNumberOfLines
        textAlignment = textAlignments(TextAlignment(rawValue: firstTextAlignment)!)
        font = fonts(Font(rawValue: firstFont)!)
        textColor = colors(Color(rawValue: firstTextColor)!)
        
        if firstRealNumberOfLines > 1 {
            setLineSpacing()
        }
        if text == "Label" {
            text = texts(Text(rawValue: firstText)!)
        }
    }
}
