import UIKit

protocol HistoryViewCellDelegate {
    func selectItem(cellNumber: Int, shouldRemove: Bool)
}

class HistoryViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    public var delegate: HistoryViewCellDelegate?
    
    public var viewModel: HistoryItemViewModel? {
        didSet { configureViewModel() }
    }
    
    private let nameLabel = UITextField.createLabelTextField(text: "")
    private let priceLabel = UITextField.createLabelTextField(text: "")
    private lazy var selectButton = UIButton.createTextButton(text: " select",
                                                              target: self,
                                                              selector: #selector(didTapSelectButton))
    private var alreadySelected = false
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapSelectButton() {
        guard let cellNumber = viewModel?.cellNumber else { return }
        delegate?.selectItem(cellNumber: cellNumber,
                             shouldRemove: alreadySelected)
        alreadySelected.toggle()
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
        priceLabel.anchor(left: nameLabel.rightAnchor,
                          paddingLeft: 30)
        priceLabel.centerY(inView: self)
        
        contentView.addSubview(selectButton)
        selectButton.anchor(right: rightAnchor,
                            paddingRight: 20)
        selectButton.centerY(inView: self)
    }
    
    func configureViewModel() {
        
        guard let viewModel = viewModel else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.banana(size: 18), .kern: 1]
        nameLabel.attributedText = NSAttributedString(string: viewModel.name, attributes: attributes)
        
        let priceAttributedText = NSMutableAttributedString(string: "￥  ")
        priceAttributedText.append(NSAttributedString(string: "\(viewModel.price)", attributes: attributes))
        priceLabel.attributedText = priceAttributedText
    }
}
