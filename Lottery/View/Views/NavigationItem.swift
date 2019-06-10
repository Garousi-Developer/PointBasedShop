import UIKit

@IBDesignable
class NavigationItem: UINavigationItem {
    @IBInspectable var firstTitle: String = Text.empty.rawValue {
        didSet {
            title = texts(Text(rawValue: firstTitle)!)
        }
    }
    @IBInspectable var firstBackButton: String = Text.empty.rawValue {
        didSet {
            backBarButtonItem = UIBarButtonItem(
                title: texts(Text(rawValue: firstBackButton)!),
                style: .plain,
                target: nil,
                action: nil
            )
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(title: String) {
        super.init(title: title)
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

extension NavigationItem {
    private func setup() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [NavigationBar.self]).setTitleTextAttributes(
            [NSAttributedString.Key.font: fonts(.medium)],
            for: .normal
        )
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [NavigationBar.self]).setTitleTextAttributes(
            [NSAttributedString.Key.font: fonts(.medium)],
            for: .highlighted
        )
        if title == "Title" {
            firstTitle = Text.empty.rawValue
        }
    }
}
