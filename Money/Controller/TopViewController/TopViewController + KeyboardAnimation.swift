import UIKit

extension TopViewController {
    
    // MARK: - Action
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
        
        if let userInfo = notification.userInfo {
            guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let height = keyboardFrame.cgRectValue.height
            print("keyboardHeight: \(height)")
            
            if isKeyboardShowing {
                if shoppingListView.frame.origin.y < 0 { return }
                shoppingListViewTopConstraint?.isActive = true
                shoppingListViewBottomConstraint?.isActive = true
                newItemInputViewBottomConstraint?.isActive = true
                view.layoutIfNeeded()
                
            } else {
                shoppingListViewTopConstraint?.isActive = false
                shoppingListViewBottomConstraint?.isActive = false
                newItemInputViewBottomConstraint?.isActive = false
                view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Helper
    
    func setupConstraint() {
        shoppingListViewTopConstraint = shoppingListView.topAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                        constant: -Dimension.keyboardHeight)
        
        shoppingListViewBottomConstraint = shoppingListView.bottomAnchor
            .constraint(equalTo: newItemInputView.topAnchor,
                        constant: -(inputCloseButtonHeight - Dimension.safeAreaBottomHeight))
        
        newItemInputViewBottomConstraint = newItemInputView.bottomAnchor
            .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                        constant: -(Dimension.keyboardHeight - Dimension.safeAreaBottomHeight))
    }
    
    func keyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
