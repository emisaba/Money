import UIKit

protocol CustomCheckBoxDelegate {
    func checkValue(isChecked: Bool)
}

class CustomCheckBox: UIView {
    
    // MARK: - Properties
    
    public var delegate: CustomCheckBoxDelegate?
    
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
    
    private var isChecked = false
    
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
        
        isChecked.toggle()
        delegate?.checkValue(isChecked: isChecked)
    }
    
    // MARK: - Helper
    
    func configureUI() {
        addSubview(checkBoxView)
        checkBoxView.fillSuperview()
        
        addSubview(checkLabel)
        checkLabel.fillSuperview()
    }
    
    func checkValue(isChecked: Bool) {
        checkLabel.isHidden = isChecked ? false : true
        self.isChecked = isChecked
    }
    
    func defaulteUI() {
        checkLabel.isHidden = true
    }
}
