import UIKit

class SavingViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let dateLabel = UITextField.createLabelTextField(text: "2021/12")
    private let priceLabel = UITextField.createLabelTextField(text: "￥100")
    
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
}
