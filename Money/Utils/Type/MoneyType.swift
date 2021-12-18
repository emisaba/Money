import UIKit

enum MoneyType {
    case income
    case spending
    case saving
    
    var title: String {
        switch self {
        case .income:
            return "income"
        case .spending:
            return "spending"
        case .saving:
            return "saving"
        }
    }
}
