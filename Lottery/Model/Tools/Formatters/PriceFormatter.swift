import Foundation

extension Int {
    var priceFormatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "٫"
        
        let priceFormattedString = numberFormatter.string(from: NSNumber(integerLiteral: self))!
        
        return priceFormattedString
    }
}
