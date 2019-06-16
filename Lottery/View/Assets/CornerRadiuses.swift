import UIKit

extension UIView {
    func setCornerRadius(_ cornerRadius: CornerRadius) {
        layer.setCornerRadius(cornerRadius)
    }
}
extension CALayer {
    func setCornerRadius(_ cornerRadius: CornerRadius) {
        switch cornerRadius {
        case .none:
            self.cornerRadius = 0
        case .medium:
            self.cornerRadius = 8
        case .large:
            self.cornerRadius = 24
        case .half:
            self.cornerRadius = min(frame.width, frame.height) / 2
        }
    }
}
enum CornerRadius: String {
    case none
    case medium
    case large
    case half
}
