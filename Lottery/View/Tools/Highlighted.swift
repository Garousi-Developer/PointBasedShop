import UIKit

extension UIColor {
    var highlighted: UIColor! {
        switch self {
        case colors(.lightAsset):
            return colors(.highlightedAsset)
        case colors(.asset):
            return colors(.highlightedAsset)
        
        case colors(.lightBlue):
            return colors(.highlightedLightBlue)
        
        case colors(.green):
            return colors(.highlightedGreen)
        
        case colors(.darkPlaceholder):
            return colors(.highlightedPlaceholder)
        
        case colors(.primary):
            return colors(.highlightedPrimary)
        
        case colors(.red):
            return colors(.highlightedRed)
        
        case colors(.white):
            return colors(.highlightedWhite)
        default:
            return nil
        }
    }
}
