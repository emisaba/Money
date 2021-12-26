import UIKit
import SDWebImage

class SavingMonthViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var viewModel: SavingMonthViewModel? {
        didSet { configureViewModel() }
    }
    
    private let categoryImage = UIImageView.createImageView(image: #imageLiteral(resourceName: "close"), radius: 25)
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
        addSubview(categoryImage)
        categoryImage.anchor(left: leftAnchor, paddingLeft: 10)
        categoryImage.setDimensions(height: 50, width: 50)
        categoryImage.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 10)
        priceLabel.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        categoryImage.sd_setImage(with: viewModel.categoryImage, completed: nil)
        priceLabel.text = viewModel.savingSum
    }
}
