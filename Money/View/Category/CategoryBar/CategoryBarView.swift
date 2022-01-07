import UIKit

protocol CategeoryBarDelegate {
    func showCategoryView()
    func showHistoryView(cell: CategoryBarCell)
    func selectedCategory(imageUrl: String)
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
        cv.register(CategoryBarCell.self, forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = .customNavyBlue()
        cv.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private var didSelectFromSelectedList = false
    private lazy var formarSelectedCell = defaultFormaerSelectedCell()
    
    private var categories = [Category(data: ["imageUrl": ""])]
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func reloadCollectionViewAfterNewCategorySelected(imageUrl: String) {
        let newCategory = Category(data: ["imageUrl": imageUrl])
        categories.append(newCategory)
        collectionView.reloadData()
        
        didSelectFromSelectedList = true
    }
    
    func reloadCollectionViewAfterCategoryFetched(categories: [Category]) {
        categories.forEach { self.categories.append($0) }
        collectionView.reloadData()
    }
    
    func shouldShowCategoryCell(cell: CategoryBarCell) {
        categeoryBarDelegate?.showCategoryView()
        cell.notSelectedUI()
    }
    
    func defaultFormaerSelectedCell() -> CategoryBarCell {
        guard let cell = collectionView.cellForItem(at:IndexPath(item: 1, section: 0)) as? CategoryBarCell else { return CategoryBarCell() }
        return cell
    }
}

// MARK: - UICollectionViewDataSource

extension CategeoryBar: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CategoryBarCell
        cell.delegate = self
        
        if didSelectFromSelectedList {
            let selectedCell = indexPath.row == categories.count - 1
            cell.viewModel = CategoryBarViewModel(category: categories[indexPath.row],
                                                  shouldSelect: selectedCell ? cell : nil,
                                                  cellNumber: indexPath.row)
            
        } else {
            let selectedCell = indexPath.row == 1
            cell.viewModel = CategoryBarViewModel(category: categories[indexPath.row],
                                                  shouldSelect: selectedCell ? cell : nil,
                                                  cellNumber: indexPath.row)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategeoryBar: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at:indexPath) as? CategoryBarCell else { return }
        
        let shouldShowCalegoryList = indexPath.item == 0
        let shouldDeselectDefaultSelectedCell = indexPath.item != 1
        let shouldDeselectLastCell = indexPath.row != categories.count - 1 && didSelectFromSelectedList
        
        if shouldShowCalegoryList {
            shouldShowCategoryCell(cell: selectedCell)
            formarSelectedCell.isSelected = true
            
        } else if shouldDeselectLastCell {
            let lastCellIndex = IndexPath(item: categories.count - 1, section: 0)
            guard let defaultSelectedCell = collectionView.cellForItem(at: lastCellIndex) as? CategoryBarCell else { return }
            defaultSelectedCell.isSelected = false
            
        } else if shouldDeselectDefaultSelectedCell {
            let selectedCellIndex = IndexPath(item: 1, section: 0)
            guard let defaultSelectedCell = collectionView.cellForItem(at: selectedCellIndex) as? CategoryBarCell else { return }
            defaultSelectedCell.isSelected = false
        }
        
        formarSelectedCell = selectedCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategeoryBar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = frame.height - 20
        return CGSize(width: 55, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

