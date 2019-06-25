import Foundation

extension String {
    var dateFormatted: String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)!
        
        dateFormatter.dateFormat = "yyyy٫MM٫dd"
        let localDateString = dateFormatter.string(from: date)
        
        return localDateString
    }
}
