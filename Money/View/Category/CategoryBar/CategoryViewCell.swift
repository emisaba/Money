import UIKit

protocol CategoryViewCellDelegate {
    func showHistoryView(image: UIButton)
}

class CategoryViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var delegate: CategoryViewCellDelegate?
    
    public var viewModel: CategoryViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var imageView = UIButton.createImageView(image: #imageLiteral(resourceName: "add"), radius: frame.width / 2)
    public lazy var historyButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "history"), target: self, selector: #selector(didTapHistoryButton))
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.backgroundColor = isSelected ? .systemGreen : .systemYellow
            historyButton.isHidden = isSelected ? false : true
        }
    }
    
    // MARK: - Action
    
    @objc func didTapHistoryButton() {
        delegate?.showHistoryView(image: imageView)
    }
    
    // MARK: - Helper
    
    func configureUI() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor)
        imageView.setDimensions(height: frame.width, width: frame.width)
        
        contentView.addSubview(historyButton)
        historyButton.isHidden = true
        historyButton.anchor(bottom: bottomAnchor)
        historyButton.setDimensions(height: 40, width: frame.width)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        if viewModel.shouldSelect { selectedUI() }
    }
    
    func notSelectedUI() {
        imageView.backgroundColor = .systemYellow
        historyButton.isHidden = true
    }
    
    func selectedUI() {
        imageView.backgroundColor = .systemGreen
        historyButton.isHidden = false
    }
}
