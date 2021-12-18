import UIKit
import Firebase

struct Category {
    let imageUrl: String
    let timeStamp: Timestamp
    
    init(data: [String: Any]) {
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.timeStamp  = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
}
