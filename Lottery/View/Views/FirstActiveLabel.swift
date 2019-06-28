import ActiveLabel

@IBDesignable
class FirstActiveLabel: ActiveLabel {
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
            let localizedText = texts(Text(rawValue: firstText)!)
            text = languageIsPersian ? localizedText.persian : localizedText.english
        }
    }
    
    var firstTextHeight: CGFloat {
        let maxSize = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        let textHeight = sizeThatFits(maxSize).height
        
        return textHeight
    }
    var firstRealNumberOfLines: Int {
        let lineHeight = font.lineHeight
        let firstNumberOfLines = lround(Double(firstTextHeight / lineHeight))
        
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
        activeSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        activeSetup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setup()
        activeSetup()
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

extension FirstActiveLabel {
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
            let localizedText = texts(Text(rawValue: firstText)!)
            text = languageIsPersian ? localizedText.persian : localizedText.english
        }
    }
    private func activeSetup() {
        let customActiveType = ActiveType.custom(pattern: "\(texts(.userAgreement))|\(texts(.privacyPolicy))")
        
        customize { (activeLabel) in
            activeLabel.lineSpacing = 8
            
            activeLabel.customColor = [customActiveType: colors(.primary)]
            activeLabel.customSelectedColor = [customActiveType: colors(.highlightedPrimary)]
            activeLabel.enabledTypes = [customActiveType]
            
            activeLabel.handleCustomTap(for: customActiveType, handler: { (pattern) in
                print(pattern)
            })
        }
    }
}
