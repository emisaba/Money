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
        addSubview(itemLabel)
        itemLabel.anchor(left: leftAnchor, paddingLeft: 10)
        itemLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 10)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        itemLabel.text = viewModel.name
        priceLabel.text = viewModel.price
    }
}
