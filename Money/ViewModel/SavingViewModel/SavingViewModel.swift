import UIKit

struct SavingViewModel {
    let saving: Saving
    
    var date: String {
        return saving.date
    }
    
    var savingPrice: Int {
        return saving.savingCost
    }
    
    init(saving: Saving) {
        self.saving = saving
    }
}
