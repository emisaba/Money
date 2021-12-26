import UIKit
import Firebase

struct SavingService {
    
    static func uploadSaving(savingInfo: SavingInfo, completion: @escaping(Error?) -> Void) {
        
        let date = DateFormatter.dateString(date: Date())
        let removeDay = date.dropLast(3)
        let documentTitle = removeDay.replacingOccurrences(of: "/", with: "")
        
        let data: [String: Any] = ["savingCost": savingInfo.cost,
                                   "categories": savingInfo.categories,
                                   "date": removeDay]
        
        COLLECTION_SAVING.document(documentTitle).setData(data, completion: completion)
    }
    
    static func fetchSaving(completion: @escaping([Saving]) -> Void) {
        COLLECTION_SAVING.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let savings = documents.map { Saving(data: $0.data()) }
            completion(savings)
        }
    }
    
    static func fetchSavingForCategories(category: String, completion: @escaping([Item]) -> Void) {
        COLLECTION_ITEMS.whereField("categoryUrl", isEqualTo: category).getDocuments { snapshot, _ in
                
                guard let documents = snapshot?.documents else { return }
                
                let items = documents.map { Item(data: $0.data()) }
                completion(items)
            }
    }
}
