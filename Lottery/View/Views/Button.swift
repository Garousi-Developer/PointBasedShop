import UIKit
import NVActivityIndicatorView

@IBDesignable
class Button: UIButton {
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
    @IBInspectable var firstBackgroundColor: String = Color.white.rawValue {
        didSet {
            backgroundColor = colors(Color(rawValue: firstBackgroundColor)!)
        }
    }
    @IBInspectable var firstTintColor: String! {
        didSet {
            tintColor = colors(Color(rawValue: firstTintColor)!)
        }
    }
    @IBInspectable var firstRTLImage: Bool = false {
        didSet {
            let flippedImage = image(for: .normal)?.withHorizontallyFlippedOrientation()
            setImage(flippedImage, for: .normal)
        }
    }
    @IBInspectable var firstFont: String = Font.medium.rawValue {
        didSet {
            titleLabel!.font = fonts(Font(rawValue: firstFont)!)
        }
    }
    @IBInspectable var firstTitleColor: String! {
        didSet {
            setTitleColor(
                colors(Color(rawValue: firstTitleColor)!),
                for: .normal
            )
        }
    }
    @IBInspectable var firstText: String = Text.empty.rawValue {
        didSet {
            setTitle(
                texts(Text(rawValue: firstText)!),
                for: .normal
            )
        }
    }
    @IBInspectable var firstInitiallyDisable: Bool = false {
        didSet {
            if firstInitiallyDisable {
                disable(animated: false)
            }
        }
    }
    @IBInspectable var firstInteractionAnimation: Bool = true {
        didSet {
            removeTarget(
                self,
                action: #selector(firstAnimateInteraction),
                for: .touchDown
            )
            removeTarget(
                self,
                action: #selector(firstAnimateInteractionReversely),
                for: [.touchUpInside, .touchDragExit, .touchCancel]
            )
        }
    }
    
    var firstInteractionAnimationType: InteractionAnimation!
    let firstInteractionAnimationDuration = durations(.interaction)
    var firstInteractionAnimator: UIViewPropertyAnimator!
    var firstReverseInteractionAnimator: UIViewPropertyAnimator!
    var firstImageAfterInteractionAnimation: UIImage?
    var firstBackgroundColorHolder: UIColor!
    var firstTintColorHolder: UIColor!
    var firstIsFirstLayout = true
    
    @objc func firstAnimateInteraction() {
        setFirstInteractionAnimator()
        
        firstInteractionAnimator.addCompletion { (_) in
            if let firstImageAfterInteractionAnimation = self.firstImageAfterInteractionAnimation {
                self.setImage(firstImageAfterInteractionAnimation, for: .normal)
            }
        }
        
        firstInteractionAnimator.startAnimation()
    }
    @objc func firstAnimateInteractionReversely() {
        let reverseDelay: TimeInterval
        if firstInteractionAnimator.isRunning {
            reverseDelay =
                firstInteractionAnimationDuration - TimeInterval(firstInteractionAnimator.fractionComplete) * firstInteractionAnimationDuration
        }
        else {
            reverseDelay = 0
        }
        
        setFirstReverseInteractionAnimator()
        
        delay(reverseDelay) {
            self.firstReverseInteractionAnimator.startAnimation()
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
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        let templateImage = image?.withRenderingMode(.alwaysTemplate)
        
        super.setImage(templateImage, for: state)
        
        setupEdgeInsets()
    }
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        
        setupEdgeInsets()
//        setTitleEdgeInsets()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setFirstInteractionAnimationType()
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
enum InteractionAnimation: String {
    case bounce
    case glow
}

extension Button {
    private func setup() {
        let templateImage = image(for: .normal)?.withRenderingMode(.alwaysTemplate)
        
        backgroundColor = colors(Color(rawValue: firstBackgroundColor)!)
        semanticContentAttribute = .forceRightToLeft
        setImage(templateImage, for: .normal)
        titleLabel!.font = fonts(Font(rawValue: firstFont)!)
        if title(for: .normal) == "Button" {
            setTitle(
                texts(Text(rawValue: firstText)!),
                for: .normal
            )
        }
        
        adjustsImageWhenDisabled = false
        adjustsImageWhenHighlighted = false
        
        addTarget(
            self,
            action: #selector(firstAnimateInteraction),
            for: .touchDown
        )
        addTarget(
            self,
            action: #selector(firstAnimateInteractionReversely),
            for: [.touchUpInside, .touchDragExit, .touchCancel]
        )
    }
    private func setupEdgeInsets() {
        if let normalTitle = title(for: .normal), image(for: .normal) != nil, !normalTitle.isEmpty {
            imageEdgeInsets.left = 4
            imageEdgeInsets.right = -4
            titleEdgeInsets.left = -4
            titleEdgeInsets.right = 4
        }
        else {
            imageEdgeInsets.left = 0
            imageEdgeInsets.right = 0
            titleEdgeInsets.left = 0
            titleEdgeInsets.right = 0
        }
    }
    private func setTitleEdgeInsets() {
        if let normalTitle = title(for: .normal), !normalTitle.isEmpty {
            titleEdgeInsets.top = 2
            titleEdgeInsets.bottom = -2
        }
    }
    private func setFirstInteractionAnimationType() {
        if backgroundColor == colors(.white) {
            firstInteractionAnimationType = .glow
        }
        else {
            firstInteractionAnimationType = .bounce
        }
    }
    private func setFirstInteractionAnimator() {
        firstInteractionAnimator = UIViewPropertyAnimator(duration: firstInteractionAnimationDuration, curve: .easeInOut) {
            switch self.firstInteractionAnimationType! {
            case .bounce:
                if self.firstBackgroundColorHolder == nil {
                    self.firstBackgroundColorHolder = self.backgroundColor
                }
                
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.backgroundColor = self.backgroundColor?.highlighted
            case .glow:
                let dominantColor = self.image(for: .normal) != nil ?
                    self.tintColor! :
                    self.titleColor(for: .normal)!
                
                if self.firstBackgroundColorHolder == nil {
                    self.firstBackgroundColorHolder = self.backgroundColor
                }
                
                self.backgroundColor = dominantColor.highlighted
            }
        }
    }
    private func setFirstReverseInteractionAnimator() {
        firstReverseInteractionAnimator = UIViewPropertyAnimator(duration: firstInteractionAnimationDuration, curve: .easeInOut) {
            switch self.firstInteractionAnimationType! {
            case .bounce:
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.backgroundColor = self.firstBackgroundColorHolder
            case .glow:
                self.backgroundColor = self.firstBackgroundColorHolder
            }
        }
    }
}
