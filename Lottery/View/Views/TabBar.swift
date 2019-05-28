import UIKit

@IBDesignable
class TabBar: UITabBar {
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

extension TabBar {
    private func setup() {
        // Remove default shadow.
        shadowImage = UIImage()
        backgroundImage = UIImage()
        
        setShadowStyle(.tabBar)
        backgroundColor = colors(.white)
        semanticContentAttribute = .forceRightToLeft
        tintColor = colors(.primary)
        unselectedItemTintColor = colors(.asset)
    }
}
