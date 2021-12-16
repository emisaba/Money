import UIKit

class CustomCheckBox: UIView {
    
    // MARK: - Properties
    
    private lazy var checkBoxView: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(didTapSquare), for: .touchUpInside)
        return button
    }()
    
    private let checkLabel: UILabel = {
        let label = UILabel()
        label.text = "✓"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapSquare() {
        checkLabel.isHidden.toggle()
    }
    
    // MARK: - Helper
    
    func configureUI() {
        addSubview(checkBoxView)
        checkBoxView.fillSuperview()
        
        addSubview(checkLabel)
        checkLabel.fillSuperview()
    }
}
