import UIKit

enum AlertType {
    case incomeAdd
    case incomeEdit
    case spendingEdit
}

protocol CustomAlertDelegate {
    func didTapOkButton(alert: CustomAlert)
    func didTapCancelButton()
}

class CustomAlert: UIView {
    
    // MARK: - Properties
    
    public var delegate: CustomAlertDelegate?
    private var alertType: AlertType = .spendingEdit
    
    private let nameTextField = UITextField.createTextField(placeholder: "")
    private let priceTextField = UITextField.createTextField(placeholder: "")
    
    private lazy var okButton = createButton(text: "OK", selector: #selector(didTapOkButton))
    private lazy var cancelButton = createButton(text: "cancel", selector: #selector(didTapCancelButton))

    public var editCompletion: ((IncomeInfo) -> Void)?
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapOkButton() {
        
        switch alertType {
        case .incomeAdd:
            delegate?.didTapOkButton(alert: self)
            
        case .incomeEdit:
            guard let incomeInfo = incomeInfo() else { return }
            editCompletion?(incomeInfo)
            
        case .spendingEdit:
            delegate?.didTapOkButton(alert: self)
        }
    }
    
    @objc func didTapCancelButton() {
        delegate?.didTapCancelButton()
    }
    
    // MARK: - Helper
    
    func configureUI() {
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .white
        
        configureTextFieldUI()
        configureButtonUI()
    }
    
    func configureTextFieldUI() {
        let textFieldStackView = UIStackView(arrangedSubviews: [nameTextField, priceTextField])
        textFieldStackView.axis = .vertical
        textFieldStackView.distribution = .fillEqually
        
        addSubview(textFieldStackView)
        textFieldStackView.anchor(top: topAnchor,
                                  left: leftAnchor,
                                  right: rightAnchor,
                                  paddingTop: 20,
                                  paddingLeft: 20,
                                  paddingRight: 20,
                                  height: 120)
        
        let textFieldStackViewFrame = UIView()
        textFieldStackViewFrame.layer.borderColor = UIColor.customLightNavyBlue().withAlphaComponent(0.2).cgColor
        textFieldStackViewFrame.layer.borderWidth = 1
        textFieldStackViewFrame.layer.cornerRadius = 5
        
        addSubview(textFieldStackViewFrame)
        textFieldStackViewFrame.anchor(top: textFieldStackView.topAnchor,
                                  left: textFieldStackView.leftAnchor,
                                  bottom: textFieldStackView.bottomAnchor,
                                  right: textFieldStackView.rightAnchor,
                                  paddingTop: -5,
                                  paddingLeft: -5,
                                  paddingBottom: -5,
                                  paddingRight: -5)
        
        let textfieldDevider = UIView()
        textfieldDevider.backgroundColor = .customLightNavyBlue().withAlphaComponent(0.2)
        addSubview(textfieldDevider)
        textfieldDevider.anchor(left: textFieldStackViewFrame.leftAnchor,
                                right: textFieldStackViewFrame.rightAnchor,
                                height: 1)
        textfieldDevider.centerY(inView: textFieldStackViewFrame)
    }
    
    func configureButtonUI() {
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, okButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.backgroundColor = .customLightNavyBlue()
        
        addSubview(buttonStackView)
        buttonStackView.anchor(left: leftAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               height: 65)
        
        let buttonStackViewDivider = UIView()
        buttonStackViewDivider.layer.borderColor = UIColor.white.cgColor
        buttonStackViewDivider.layer.borderWidth = 1
        buttonStackViewDivider.layer.cornerRadius = 5
        
        addSubview(buttonStackViewDivider)
        buttonStackViewDivider.anchor(bottom: bottomAnchor, paddingBottom: -2)
        buttonStackViewDivider.setDimensions(height: 70, width: 1)
        buttonStackViewDivider.centerX(inView: buttonStackView)
    }
    
    func createButton(text: String, selector: Selector) -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.clipsToBounds = true
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 20), .kern: 3, .foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: text, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
    
    func setItemInfo(info: ItemInfo) {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.customNavyBlue(),
                                                         .font: UIFont.abraham(size: 18),
                                                         .kern: 2]
        nameTextField.attributedText = NSAttributedString(string: info.name, attributes: attributes)
        priceTextField.attributedText = NSAttributedString(string: "\(info.price)", attributes: attributes)
    }
    
    func itemInfo() -> ItemInfo? {
        guard let name = nameTextField.text else { return nil }
        guard let price = priceTextField.text else { return nil }
        guard let priceInt = Int(price) else { return nil }
        
        return ItemInfo(name: name, price: priceInt)
    }
    
    func incomeInfo() -> IncomeInfo? {
        guard let name = nameTextField.text else { return nil }
        guard let price = priceTextField.text else { return nil }
        guard let priceInt = Int(price) else { return nil }
        
        return IncomeInfo(name: name, price: priceInt)
    }
    
    func addIncome() {
        alertType = .incomeAdd
        nameTextField.text = ""
        priceTextField.text = ""
    }
    
    func editIncome(info: IncomeInfo) {
        nameTextField.text = info.name
        priceTextField.text = "\(info.price)"
        alertType = .incomeEdit
    }
}
