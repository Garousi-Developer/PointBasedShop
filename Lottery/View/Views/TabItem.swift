import UIKit

@IBDesignable
class TabItem: UITabBarItem {
    @IBInspectable var firstTitle: String! {
        didSet {
            title = texts(Text(rawValue: firstTitle)!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init() {
        super.init()
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

extension TabItem {
    private func setup() {
        setTitleTextAttributes(
            [NSAttributedString.Key.font: fonts(.small)],
            for: .normal
        )
    }
}
