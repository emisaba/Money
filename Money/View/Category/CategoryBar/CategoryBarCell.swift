import UIKit
import SDWebImage

protocol CategoryBarCellDelegate {
    func showHistoryView(cell: CategoryBarCell)
    func selectedCategoryUrl(url: String)
}

class CategoryBarCell: CategoryCell {
    
    // MARK: - Properties
    
    public var delegate: CategoryBarCellDelegate?
    
    public var viewModel: CategoryBarViewModel? {
        didSet { configureViewModel() }
    }
    
    public lazy var historyButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "history"), target: self, selector: #selector(didTapHistoryButton))
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHistoryButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.backgroundColor = isSelected ? .systemGreen : .systemYellow
            historyButton.isHidden = isSelected ? false : true
            
            if isSelected {
                guard let url = viewModel?.imageUrl?.absoluteString else { return }
                delegate?.selectedCategoryUrl(url: url)
            }
        }
    }
    
    // MARK: - Action
    
    @objc func didTapHistoryButton() {
        delegate?.showHistoryView(cell: self)
    }
    
    // MARK: - Helper
    
    func configureHistoryButton() {
        
        contentView.addSubview(historyButton)
        historyButton.isHidden = true
        historyButton.anchor(bottom: bottomAnchor)
        historyButton.setDimensions(height: 40, width: frame.width)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        imageView.sd_setImage(with: viewModel.imageUrl, for: .normal, completed: nil)
        self.isSelected = viewModel.shouldSelect ? true : false
    }
    
    func notSelectedUI() {
        imageView.backgroundColor = .systemYellow
        historyButton.isHidden = true
    }
}
