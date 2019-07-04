import UIKit

@IBDesignable
class NavigationItem: UINavigationItem {
    @IBInspectable var firstTitle: String = Text.empty.rawValue {
        didSet {
            let localizedTitle = texts(Text(rawValue: firstTitle)!)
            title = languageIsPersian ? localizedTitle.persian : localizedTitle.english
        }
    }
    @IBInspectable var firstBackButton: String = Text.empty.rawValue {
        didSet {
            let localizedBackButtonTitle = texts(Text(rawValue: firstTitle)!)
            backBarButtonItem = UIBarButtonItem(
                title: languageIsPersian ? localizedBackButtonTitle.persian : localizedBackButtonTitle.english,
                style: .plain,
                target: nil,
                action: nil
            )
        }
    }
    var localizedTitle: LocalizedText! {
        didSet {
            title = languageIsPersian ? localizedTitle.persian : localizedTitle.english
        }
    }
    var localizedBackButtonTitle: LocalizedText! {
        didSet {
            backBarButtonItem = UIBarButtonItem(
                title: languageIsPersian ? localizedBackButtonTitle.persian : localizedBackButtonTitle.english,
                style: .plain,
                target: nil,
                action: nil
            )
        }
    }
    var backButtonTitle: String! {
        didSet {
            backBarButtonItem = UIBarButtonItem(
                title: backButtonTitle,
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
