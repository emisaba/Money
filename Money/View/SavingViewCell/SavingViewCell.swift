import UIKit

class SavingViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: SavingViewModel? {
        didSet { configureViewModel()  }
    }
    
    private let dateLabel = UITextField.createLabelTextField(text: "")
    private let priceLabel = UITextField.createLabelTextField(text: "")
    
    private let nextPageButton = UIButton.createImageView(image: #imageLiteral(resourceName: "arrow-right"), radius: 0)
    
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
        
        addSubview(dateLabel)
        dateLabel.anchor(left: leftAnchor,
                         paddingLeft: 20)
        dateLabel.centerY(inView: self)
        
        addSubview(nextPageButton)
        nextPageButton.anchor(right: rightAnchor, paddingRight: 10)
        nextPageButton.setDimensions(height: 30, width: 30)
        nextPageButton.centerY(inView: self)
        nextPageButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: nextPageButton.leftAnchor, paddingRight: 20)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 18), .kern: 1]
        dateLabel.attributedText = NSAttributedString(string: viewModel.date, attributes: attributes)
        
        let priceAttributedText = NSMutableAttributedString(string: "￥  ")
        priceAttributedText.append(NSAttributedString(string: "\(viewModel.savingPrice)", attributes: attributes))
        priceLabel.attributedText = priceAttributedText
    }
}
