import UIKit

protocol CategeoryBarDelegate {
    func showCategoryView()
    func showHistoryView(image: UIButton)
}

class CategeoryBar: UIView {
    
    // MARK: - Properties
    
    public var categeoryBarDelegate: CategeoryBarDelegate?
    
    private let identifier = "identifier"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(CategoryViewCell.self, forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .systemPink
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension CategeoryBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CategoryViewCell
        cell.viewModel = CategoryViewModel(cellNumber: indexPath.row)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategeoryBar: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let defaultSelectedCell = collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) else { return }
        guard let selectedCell = collectionView.cellForItem(at:indexPath) as? CategoryViewCell else { return }
        
        if indexPath.row == 0 {
            categeoryBarDelegate?.showCategoryView()
            selectedCell.notSelectedUI()
        }
        
        if indexPath.row != 1 { defaultSelectedCell.isSelected = false }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategeoryBar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = frame.height - 20
        return CGSize(width: 60, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - CategoryViewCellDelegate

extension CategeoryBar: CategoryViewCellDelegate {
    func showHistoryView(image: UIButton) {
        categeoryBarDelegate?.showHistoryView(image: image)
    }
}
