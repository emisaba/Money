import UIKit

struct Item {
    let spendingType: String
    let categoryUrl: String
    var name: String
    var price: Int
    var isChecked: Bool
    let itemID: String
    
    init(data: [String: Any]) {
        self.spendingType = data["spendingType"] as? String ?? ""
        self.categoryUrl = data["categoryUrl"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.price = data["price"] as? Int ?? 0
        self.isChecked = data["isChecked"] as? Bool ?? true
        self.itemID = data["itemID"] as? String ?? ""
    }
}
