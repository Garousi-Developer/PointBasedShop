import UIKit

extension UILabel {
    func setLineSpacing() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineSpacing = 8
        
        let attributedText = NSAttributedString(
            string: text!,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        
        self.attributedText = attributedText
    }
}
