import UIKit

var languageIsPersian: Bool {
    if let language = UserDefaults.standard.string(forKey: "language") {
        switch language {
        case "persian":
            return true
        case "english":
            return false
        default:
            return true
        }
    }
    else {
        return true
    }
}

func switchToEnglish() {
    UIView.appearance().semanticContentAttribute = .forceRightToLeft
    
    UITabBar.appearance().semanticContentAttribute = .forceLeftToRight
    UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
    UIStackView.appearance().semanticContentAttribute = .forceLeftToRight
    UIButton.appearance().semanticContentAttribute = .forceLeftToRight
    UISearchBar.appearance().semanticContentAttribute = .forceLeftToRight
    UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
    
    UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
}
func switchToPersian() {
    UIView.appearance().semanticContentAttribute = .forceLeftToRight
    
    UITabBar.appearance().semanticContentAttribute = .forceRightToLeft
    UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
    UIStackView.appearance().semanticContentAttribute = .forceRightToLeft
    UIButton.appearance().semanticContentAttribute = .forceRightToLeft
    UISearchBar.appearance().semanticContentAttribute = .forceRightToLeft
    UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
    
    UINavigationBar.appearance().semanticContentAttribute = .forceLeftToRight
}
