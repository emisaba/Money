import UIKit

struct ItemViewModel {
    let item: Item
    
    var isChecked: Bool {
        return item.isChecked
    }
    
    var name: String {
        return item.name
    }
    
    var price: String {
        return "￥ \(item.price)"
    }
    
    init(item: Item) {
        self.item = item
    }
}
