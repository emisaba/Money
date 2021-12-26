import UIKit

class SavingViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: SavingViewModel? {
        didSet { configureViewModel()  }
    }
    
    private let dateLabel = UITextField.createLabelTextField(text: "")
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
        
        addSubview(dateLabel)
        dateLabel.anchor(left: leftAnchor,
                         paddingLeft: 10)
        dateLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 10)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        dateLabel.text = viewModel.date
        priceLabel.text = viewModel.savingPrice
    }
}
