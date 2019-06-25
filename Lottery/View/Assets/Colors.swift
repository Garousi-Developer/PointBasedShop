import UIKit

func colors(_ color: Color) -> UIColor {
    switch color {
    case .highlightedAsset:
        return MaterialColors.grey400
    case .lightAsset:
        return MaterialColors.primaryGrey
    case .asset:
        return MaterialColors.grey700
    case .darkAsset:
        return MaterialColors.black
    
    case .transparentBlack:
        return colors(.black).withAlphaComponent(0.5)
    case .black:
        return MaterialColors.black
    
    case .clear:
        return MaterialColors.clear
    
    case .cyan:
        return MaterialColors.primaryCyan
    
    case .disabled:
        return MaterialColors.grey300
    
    case .highlightedGreen:
        return MaterialColors.green200
    case .green:
        return MaterialColors.primaryGreen
    
    case .lightGrey:
        return MaterialColors.grey300
    case .grey:
        return MaterialColors.primaryGrey
    
    case .line:
        return MaterialColors.grey300
    case .semiDarkLine:
        return MaterialColors.grey400
    case .darkLine:
        return MaterialColors.primaryGrey
    
    case .lightPlaceholder:
        return MaterialColors.grey100
    case .highlightedPlaceholder:
        return MaterialColors.grey200
    case .placeholder:
        return MaterialColors.grey200
    case .darkPlaceholder:
        return MaterialColors.grey300
    
    case .highlightedPrimary:
        return MaterialColors.amber200
    case .primary:
        return MaterialColors.primaryAmber
    
    case .highlightedRed:
        return MaterialColors.red100
    case .red:
        return MaterialColors.primaryRed
    
    case .transparentWhite:
        return colors(.white).withAlphaComponent(0.5)
    case .highlightedWhite:
        return colors(.white).withAlphaComponent(0.35)
    case .white:
        return MaterialColors.white
    }
}
enum Color: String {
    case highlightedAsset
    case lightAsset
    case asset
    case darkAsset
    
    case transparentBlack
    case black
    
    case clear
    
    case cyan
    
    case disabled
    
    case highlightedGreen
    case green
    
    case lightGrey
    case grey
    
    case line
    case semiDarkLine
    case darkLine
    
    case highlightedPlaceholder
    case lightPlaceholder
    case placeholder
    case darkPlaceholder
    
    case highlightedPrimary
    case primary
    
    case highlightedRed
    case red
    
    case transparentWhite
    case highlightedWhite
    case white
}
