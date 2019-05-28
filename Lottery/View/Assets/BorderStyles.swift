import UIKit

extension UIView {
    func setBorderStyle(_ borderStyle: BorderStyle) {
        layer.setBorderStyle(borderStyle)
    }
}
extension CALayer {
    func setBorderStyle(_ borderStyle: BorderStyle) {
        switch borderStyle {
        case .none:
            borderWidth = 0
        case .normal:
            borderWidth = 1
            borderColor = colors(.line).cgColor
        case .thick:
            borderWidth = 2
            borderColor = colors(.line).cgColor
        }
    }
}
enum BorderStyle: String {
    case none
    case normal
    case thick
}
