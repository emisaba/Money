import UIKit

class IncomeViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: IncomeViewModel? {
        didSet { configureViewModel() }
    }
    
    private let nameLabel = UITextField.createLabelTextField(text: "")
    private let priceLabel = UITextField.createLabelTextField(text: "")
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureUI() {
        selectionStyle = .none
        backgroundColor = .customNavyBlue()
        
        addSubview(nameLabel)
        nameLabel.anchor(left: leftAnchor,
                             paddingLeft: 20)
        nameLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 20)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 17), .kern: 3]
        nameLabel.attributedText = NSAttributedString(string: viewModel.name, attributes: attributes)
        
        let priceAttributedText = NSMutableAttributedString(string: "￥  ")
        priceAttributedText.append(NSAttributedString(string: "\(viewModel.price)", attributes: attributes))
        priceLabel.attributedText = priceAttributedText
    }
    
    func returnIncomInfo() -> IncomeInfo? {
        guard let name = nameLabel.text else { return nil }
        guard let price = priceLabel.text?.replacingOccurrences(of: "￥ ", with: "") else { return nil }
        guard let intPrice = Int(price) else { return nil }
        
        return IncomeInfo(name: name, price: intPrice)
    }
}
