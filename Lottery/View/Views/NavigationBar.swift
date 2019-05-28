import UIKit

@IBDesignable
class NavigationBar: UINavigationBar {
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

extension NavigationBar {
    private func setup() {
        // Remove default shadow.
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
        
        setShadowStyle(.navigationBar)
        backgroundColor = colors(.white)
        tintColor = colors(.darkAsset)
        titleTextAttributes = [
            NSAttributedString.Key.font: fonts(.semiLarge),
            NSAttributedString.Key.foregroundColor: colors(.darkAsset)
        ]
    }
}
