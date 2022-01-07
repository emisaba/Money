import UIKit

class SavingCategoryViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: ItemViewModel? {
        didSet { configureViewModel() }
    }
    
    private let itemLabel = UILabel.createBoldFontLabel(text: "", size: 18)
    private let priceLabel = UILabel.createBoldFontLabel(text: "", size: 18)
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        selectionStyle = .none
        backgroundColor = .customNavyBlue()
        
        addSubview(itemLabel)
        itemLabel.anchor(left: leftAnchor, paddingLeft: 20)
        itemLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 20)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 17), .kern: 3, .foregroundColor: UIColor.white]
        let itemLabelAttributedText = NSAttributedString(string: "\(viewModel.name)", attributes: attributes)
        itemLabel.attributedText = itemLabelAttributedText
        
        let priceLabelAttributedText = NSMutableAttributedString(string: "￥ ", attributes: attributes)
        priceLabelAttributedText.append(NSAttributedString(string: "\(viewModel.price)", attributes: attributes))
        priceLabel.attributedText = priceLabelAttributedText
    }
}
