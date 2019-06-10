import UIKit

extension UIColor {
    var highlighted: UIColor! {
        switch self {
        case colors(.lightAsset):
            return colors(.highlightedAsset)
        case colors(.asset):
            return colors(.highlightedAsset)
        case colors(.primary):
            return colors(.highlightedPrimary)
        case colors(.red):
            return colors(.highlightedRed)
        default:
            return nil
        }
    }
}
