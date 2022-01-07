import UIKit

protocol CustomSegmentControlDelegate {
    func changeSegmentValue(spendingType: SpendingType)
}

class CustomSegmentControl: UIView {
    
    // MARK: - Properties
    
    public var delegate: CustomSegmentControlDelegate?
    
    private lazy var fixedButton = createTextButton(title: "  fixced", selector: #selector(didTapFixedButton), isDefaultSelected: true)
    private lazy var variableButton = createTextButton(title: "variable ", selector:  #selector(didTapVariableButton), isDefaultSelected: false)
    
    private lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow()
        view.layer.cornerRadius = (frame.height - 20) / 2
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    // MARK: - Action
    
    @objc func didTapFixedButton() {
        
        delegate?.changeSegmentValue(spendingType: .fixed)
        
        UIView.animate(withDuration: 0.25, delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: .curveEaseInOut) {
            
            self.selectedView.frame.origin.x = 10
            
            self.fixedButton.setTitleColor(.customNavyBlue(), for: .normal)
            self.variableButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @objc func didTapVariableButton() {
        
        delegate?.changeSegmentValue(spendingType: .variable)
        
        UIView.animate(withDuration: 0.25, delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: .curveEaseInOut) {
            
            self.selectedView.frame.origin.x = self.frame.width / 2
            
            self.fixedButton.setTitleColor(.white, for: .normal)
            self.variableButton.setTitleColor(.customNavyBlue(), for: .normal)
        }
        
    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        addSubview(selectedView)
        selectedView.frame = CGRect(x: 10, y: 10,
                                    width: frame.width - (frame.width / 2 + 10),
                                    height: frame.height - 20)
        
        let stackView = UIStackView(arrangedSubviews: [fixedButton, variableButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.frame = bounds
    }
    
    func createTextButton(title: String, selector: Selector, isDefaultSelected: Bool) -> UIButton {
        let button = UIButton()
        button.setTitleColor(isDefaultSelected ? .customNavyBlue() : .white, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 15), .kern: 3]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}
