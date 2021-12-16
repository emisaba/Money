import UIKit

extension UIButton {
    
    static func createImageButton(image: UIImage, target: Any?, selector: Selector) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = .systemPink
        button.addTarget(target, action: selector, for: .touchUpInside)
        return button
    }
    
    static func createImageView(image: UIImage, radius: CGFloat) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = radius
        button.isUserInteractionEnabled = false
        return button
    }
    
    static func createTextButton(text: String, target: Any?, selector: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = .systemGray
        button.addTarget(target, action: selector, for: .touchUpInside)
        return button
    }
}
