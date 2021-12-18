import UIKit

class CategoryBarViewModel {
    let category: Category
    let selectedCell: CategoryBarCell?
    let cellNumber: Int
    
    var shouldSelect: Bool {
        return selectedCell != nil
    }
    
    var imageUrl: URL? {
        return URL(string: category.imageUrl)
    }
    
    init(category: Category, shouldSelect: CategoryBarCell?, cellNumber: Int) {
        self.category = category
        self.selectedCell = shouldSelect
        self.cellNumber = cellNumber
    }
}
