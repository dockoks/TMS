import SwiftUI

extension Date {
    func toString(format: String = "dd.MM.yy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
