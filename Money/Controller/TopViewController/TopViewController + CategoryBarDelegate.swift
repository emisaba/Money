import UIKit
import Hero

extension TopViewController: CategeoryBarDelegate {
    func selectedCategory(imageUrl: String) {
        selectedCategoryImageUrl = imageUrl
        showSelectedList()
    }
    
    func showHistoryView(image: UIButton) {
        image.hero.id = "showHistoryView"
        
        let vc = HistoryViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.mainImageView.hero.id = "showHistoryView"
        vc.isHeroEnabled = true
        
        present(vc, animated: true, completion: nil)
    }
    
    func showCategoryView() {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.categoryListView.frame.origin.y -= self.categoryViewHeight
            self.backgroundView.alpha = 1
        }
    }
}
