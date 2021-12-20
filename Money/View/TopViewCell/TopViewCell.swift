import UIKit

protocol TopViewCellDelegate {
    func checkValue(item: Item)
}

class TopViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var delegate: TopViewCellDelegate?
    
    public var viewModel: ItemViewModel? {
        didSet { configureViewModel() }
    }
    
    private let squareView = CustomCheckBox()
    private let nameLabel = UITextField.createLabelTextField(text: "")
    private let priceLabel = UITextField.createLabelTextField(text: "")
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureUI() {
        selectionStyle = .none
        backgroundColor = .systemPink
        
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
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        squareView.topViewCellCheckValue(isChecked: viewModel.isChecked)
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
    }
    
    func setDelegate() {
        squareView.delegate = self
    }
}
