import UIKit

extension UIImage {
    func withInsets(_ insets: UIEdgeInsets) -> UIImage {
        let newOrigin = CGPoint(
            x: insets.left,
            y: insets.top
        )
        let imageWithInsets: UIImage
        
        UIGraphicsBeginImageContextWithOptions(
            CGSize(
                width: insets.left + size.width + insets.right,
                height: insets.top + size.height + insets.bottom
            ),
            false,
            self.scale
        )
        draw(at: newOrigin)
        imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return imageWithInsets
    }
}
