import UIKit
import Firebase

struct Saving {
    let savingCost: Int
    let categories: [String]
    let date: String
    
    init(data: [String: Any]) {
        self.savingCost = data["savingCost"] as? Int ?? 0
        self.categories = data["categories"] as? [String] ?? [""]
        self.date = data["date"] as? String ?? ""
    }
}
