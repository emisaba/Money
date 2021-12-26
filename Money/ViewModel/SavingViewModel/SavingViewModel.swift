import UIKit

struct SavingViewModel {
    let saving: Saving
    
    var date: String {
        return saving.date
    }
    
    var savingPrice: String {
        return "￥ \(saving.savingCost)"
    }
    
    init(saving: Saving) {
        self.saving = saving
    }
}
