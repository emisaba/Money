import UIKit
import Firebase

struct Category {
    let imageUrl: String
    let date: String
    
    init(data: [String: Any]) {
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.date  = data["date"] as? String ?? ""
    }
}
