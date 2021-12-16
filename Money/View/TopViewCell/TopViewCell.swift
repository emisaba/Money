import UIKit

class TopViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let squareView = CustomCheckBox()
    private let nameLabel = UITextField.createLabelTextField(text: "にんじん")
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
        
        contentView.addSubview(squareView)
        squareView.anchor(left: leftAnchor,
                          paddingLeft: 10)
        squareView.setDimensions(height: 25, width: 25)
        squareView.centerY(inView: self)
        
        addSubview(nameLabel)
        nameLabel.anchor(left: squareView.rightAnchor,
                             paddingLeft: 10)
        nameLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(right: rightAnchor, paddingRight: 10)
        priceLabel.centerY(inView: self)
    }
}
