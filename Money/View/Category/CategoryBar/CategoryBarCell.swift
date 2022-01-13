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
            if viewModel?.cellNumber == 0 { return }
            
            imageView.backgroundColor = isSelected ? .customYellow() : .clear
            historyButton.isHidden = isSelected ? false : true
            
            if isSelected {
                guard let url = viewModel?.imageUrl?.absoluteString else { return }
                delegate?.selectedCategoryUrl(url: url)
            } else {
                let image = imageView.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
                imageView.setImage(image, for: .normal)
                imageView.tintColor = .white
                imageView.layer.borderWidth = 0
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
        
        if viewModel.cellNumber == 0 {
            imageView.setImage(#imageLiteral(resourceName: "add-line"), for: .normal)
            imageView.layer.borderWidth = 2
            imageView.layer.borderColor = UIColor.white.cgColor
        } else {
            imageView.sd_setImage(with: viewModel.imageUrl, for: .normal, completed: nil)
            self.isSelected = viewModel.shouldSelect ? true : false
        }
    }
    
    func notSelectedUI() {
        if viewModel?.cellNumber == 0 { return }
        
        imageView.backgroundColor = .customYellow()
        historyButton.isHidden = true
    }
}
