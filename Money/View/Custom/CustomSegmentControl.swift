import UIKit

class CustomSegmentControl: UIView {
    
    // MARK: - Properties
    
    private lazy var fixedButton = createButton(title: "固定", selector: #selector(didTapFixedButton))
    private lazy var variableButton = createButton(title: "変動", selector:  #selector(didTapVariableButton))
    
    private lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = (frame.height - 10) / 2
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    // MARK: - Action
    
    @objc func didTapFixedButton() {
        
        UIView.animate(withDuration: 0.25, delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: .curveEaseInOut) {
            
            self.selectedView.frame.origin.x = 5
        }
    }
    
    @objc func didTapVariableButton() {
        
        UIView.animate(withDuration: 0.25, delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: .curveEaseInOut) {
            
            self.selectedView.frame.origin.x = self.frame.width / 2
        }
    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        addSubview(selectedView)
        selectedView.frame = CGRect(x: 5, y: 5,
                                    width: frame.width - (frame.width / 2 + 5),
                                    height: frame.height - 10)
        
        let stackView = UIStackView(arrangedSubviews: [fixedButton, variableButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.frame = bounds
    }
    
    func createButton(title: String, selector: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}
