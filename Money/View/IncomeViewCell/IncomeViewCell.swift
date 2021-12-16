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
        
        addSubview(nameLabel)
        nameLabel.anchor(left: leftAnchor,
                             paddingLeft: 10)
        nameLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 10)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
    }
    
    func returnIncomInfo() -> IncomeInfo? {
        guard let name = nameLabel.text else { return nil }
        guard let price = priceLabel.text?.replacingOccurrences(of: "￥ ", with: "") else { return nil }
        guard let intPrice = Int(price) else { return nil }
        
        return IncomeInfo(name: name, price: intPrice)
    }
}
