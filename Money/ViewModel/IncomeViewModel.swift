import UIKit

struct IncomeViewModel {
    let income: Income
    
    var name: String {
        return income.name
    }
    
    var price: String {
        return "￥ \(income.price)"
    }
    
    init(income: Income) {
        self.income = income
    }
}
