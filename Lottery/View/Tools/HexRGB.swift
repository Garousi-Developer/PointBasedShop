import UIKit

extension UIColor {
    convenience init(hexRGB: Int) {
        let red = CGFloat(hexRGB >> 16) / 255
        let green = CGFloat(hexRGB >> 8 & 0xFF) / 255
        let blue = CGFloat(hexRGB & 0xFF) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
