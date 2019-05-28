import UIKit

extension UIView {
    func setShadowStyle(_ shadowStyle: ShadowStyle) {
        layer.setShadowStyle(shadowStyle)
    }
}
extension CALayer {
    func setShadowStyle(_ shadowStyle: ShadowStyle) {
        switch shadowStyle {
        case .navigationBar:
            shadowOffset = CGSize(width: 0, height: 3)
            shadowOpacity = 0.075
        case .none:
            shadowOpacity = 0
        case .normal:
            shadowOffset = CGSize(width: 0, height: 0)
            shadowOpacity = 0.125
        case .tabBar:
            shadowOpacity = 0.075
        }
    }
}
enum ShadowStyle: String {
    case navigationBar
    case none
    case normal
    case tabBar
}
