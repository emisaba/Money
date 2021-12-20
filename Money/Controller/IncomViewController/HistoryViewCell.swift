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
    private lazy var selectButton = UIButton.createTextButton(text: "select",
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
        
        addSubview(nameLabel)
        nameLabel.anchor(left: leftAnchor,
                         paddingLeft: 10)
        nameLabel.centerY(inView: self)
        
        addSubview(priceLabel)
        priceLabel.anchor(left: nameLabel.rightAnchor,
                          paddingLeft: 30)
        priceLabel.centerY(inView: self)
        
        contentView.addSubview(selectButton)
        selectButton.anchor(right: rightAnchor,
                            paddingRight: 10)
        selectButton.centerY(inView: self)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
    }
}
