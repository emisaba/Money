import UIKit
import Firebase

struct CategoryService {
    
    static func uploadCategory(image: UIImage, completion: @escaping(String) -> Void) {
        ImageUploader.uploadImage(image: image) { imageUrl in
            
            let date = DateFormatter.dateString(date: Date())
            let removeDay = date.dropLast(3)
            
            let data: [String: Any] = ["imageUrl": imageUrl,
                                       "date": removeDay]
            
            COLLECTION_CATEGORIES.addDocument(data: data) { error in
                if let error = error {
                    print("failed to upload category: \(error.localizedDescription)")
                    return
                }
                
                completion(imageUrl)
            }
        }
    }
    
    static func fetchCategories(completion: @escaping([Category]) -> Void) {
        COLLECTION_CATEGORIES.order(by: "timeStamp", descending: false).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let categories = documents.map { Category(data: $0.data()) }
            completion(categories)
        }
    }
}
