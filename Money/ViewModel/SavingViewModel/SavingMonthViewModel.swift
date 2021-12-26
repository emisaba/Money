import UIKit

struct SavingMonthViewModel {
    let saving: SavingMonth
    
    var categoryImage: URL? {
        return URL(string: saving.categoryUrl)
    }
    
    var savingSum: String {
        return String(saving.savingSum)
    }
    
    var items: [Item] {
        return saving.items
    }
    
    init(saving: SavingMonth) {
        self.saving = saving
    }
}
