import Foundation

extension Int {
    var priceFormatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = languageIsPersian ? "٬" : ","
        
        let priceFormattedString = numberFormatter.string(from: NSNumber(integerLiteral: self))!
        
        return priceFormattedString
    }
}
extension String {
    var priceFormatted: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = languageIsPersian ? "٬" : ","
        
        guard let integeredString = Int(self.replacingOccurrences(of: numberFormatter.groupingSeparator, with: "")) else {
            return ""
        }
        let priceFormattedString = numberFormatter.string(from: NSNumber(integerLiteral: integeredString))!
        
        return priceFormattedString
    }
}
