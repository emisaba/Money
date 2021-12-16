import UIKit

extension UILabel {
    
    static func createBoldFontLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: size)
        return label
    }
}
