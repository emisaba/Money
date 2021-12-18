import UIKit

class CategoryListCell: CategoryCell {
    
    // MARK: - Properties
    
    public var categoryImage: UIImage = UIImage() {
        didSet { setCategoryListImage(image: categoryImage) }
    }
    
    // MARK: - Helpers
    
    func setCategoryListImage(image: UIImage) {
        imageView.setImage(image, for: .normal)
    }
}
