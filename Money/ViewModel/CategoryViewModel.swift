import UIKit

class CategoryViewModel {
    let cellNumber: Int
    
    var shouldSelect: Bool {
        return cellNumber == 1
    }
    
    init(cellNumber: Int) {
        self.cellNumber = cellNumber
    }
}
