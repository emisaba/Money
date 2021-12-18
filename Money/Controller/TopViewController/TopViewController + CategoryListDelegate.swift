import UIKit

extension TopViewController: CategoryListViewDelegate {
    func selectCategory(image: UIImage) {
        uploadNewCategory(image: image)
    }
}
