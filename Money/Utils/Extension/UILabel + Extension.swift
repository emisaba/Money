import UIKit

extension UILabel {
    
    static func createBoldFontLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: size)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: size), .kern: 3]
        label.attributedText = NSAttributedString(string: text, attributes: attributes)
        
        return label
    }
}
