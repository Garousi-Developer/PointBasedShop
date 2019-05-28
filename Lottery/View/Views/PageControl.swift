import UIKit
import CHIPageControl

@IBDesignable
class PageControl: CHIPageControlAleppo {
    @IBInspectable var firstTintColor: String = Color.primary.rawValue {
        didSet {
            tintColor = colors(Color(rawValue: firstTintColor)!)
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
}

extension PageControl {
    private func setup() {
        backgroundColor = colors(.clear)
        radius = 5
        firstTintColor = Color.primary.rawValue
        inactiveTransparency = 0.25
        padding = 4
    }
}
