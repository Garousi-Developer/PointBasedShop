import BetterSegmentedControl

@IBDesignable
class SegmentedControl: BetterSegmentedControl {
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect, segments: [BetterSegmentedControlSegment], index: UInt = 0, options: [BetterSegmentedControlOption]? = nil) {
        super.init(frame: frame, segments: segments, index: index, options: options)
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

extension SegmentedControl {
    private func setup() {
        options = [
            .cornerRadius(8),
            .backgroundColor(colors(.primary)),
            .indicatorViewBackgroundColor(colors(.white))
        ]
        segments = LabelSegment.segments(
            withTitles: [texts(.english).english, texts(.persian).persian],
            normalBackgroundColor: nil,
            normalFont: fonts(.medium),
            normalTextColor: colors(.white),
            selectedBackgroundColor: nil,
            selectedFont: fonts(.medium),
            selectedTextColor: colors(.primary)
        )
    }
}
