import UIKit

func fonts(_ font: Font) -> UIFont {
    switch font {
    case .small:
        return languageIsPersian ? iranSansMobilePersianNumerals.withSize(scale * 8) : iranSansMobile.withSize(scale * 8)
    case .semiSmall:
        return languageIsPersian ? iranSansMobilePersianNumerals.withSize(scale * 10) : iranSansMobile.withSize(scale * 10)
    case .medium:
        return languageIsPersian ? iranSansMobilePersianNumerals.withSize(scale * 12) : iranSansMobile.withSize(scale * 12)
    case .semiLarge:
        return languageIsPersian ? iranSansMobilePersianNumerals.withSize(scale * 14) : iranSansMobile.withSize(scale * 14)
    case .large:
        return languageIsPersian ? iranSansMobilePersianNumerals.withSize(scale * 16) : iranSansMobile.withSize(scale * 16)
    case .extraLarge:
        return languageIsPersian ? iranSansMobilePersianNumerals.withSize(scale * 20) : iranSansMobile.withSize(scale * 20)
    }
}
enum Font: String {
    case small
    case semiSmall
    case medium
    case semiLarge
    case large
    case extraLarge
}

private let iranSansMobilePersianNumerals = UIFont(name: "IRANSansMobileFaNum", size: -1)!
private let iranSansMobile = UIFont(name: "IRANSansMobile", size: -1)!
