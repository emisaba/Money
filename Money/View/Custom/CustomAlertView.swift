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
    private let okButton = UIButton.createTextButton(text: "ok", target: self, selector: #selector(didTapOkButton))
    private let cancelButton = UIButton.createTextButton(text: "cancel", target: self, selector: #selector(didTapCancelButton))
    
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
        layer.cornerRadius = 20
        backgroundColor = .white
        
        addSubview(nameTextField)
        nameTextField.anchor(top: topAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             paddingTop: 20,
                             paddingLeft: 20,
                             paddingRight: 20,
                             height: 50)
        
        addSubview(priceTextField)
        priceTextField.anchor(top: nameTextField.bottomAnchor,
                              left: leftAnchor,
                              right: rightAnchor,
                              paddingTop: 20,
                              paddingLeft: 20,
                              paddingRight: 20,
                              height: 50)
        
        let buttonStackView = UIStackView(arrangedSubviews: [okButton, cancelButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        
        addSubview(buttonStackView)
        buttonStackView.anchor(top: priceTextField.bottomAnchor,
                               left: leftAnchor,
                               bottom: bottomAnchor,
                               right: rightAnchor,
                               paddingTop: 20,
                               paddingLeft: 20,
                               paddingBottom: 20,
                               paddingRight: 20,
                               height: 60)
    }
    
    func setItemInfo(info: ItemInfo) {
        nameTextField.text = info.name
        priceTextField.text = "\(info.price)"
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
