import UIKit

enum MoneyState {
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
