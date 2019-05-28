import UIKit

extension UIView {
    func subview(withLayerName layerName: String) -> UIView? {
        return subviews.first { subview in
            return subview.layer.name == layerName
        }
    }
    func removeSubview(withLayerName layerName: String) {
        if let subview = subview(withLayerName: layerName) {
            subview.removeFromSuperview()
        }
    }
}
