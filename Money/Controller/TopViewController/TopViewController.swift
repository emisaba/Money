import UIKit

class TopViewController: UIViewController {
    
    // MARK: - Properties
    
    public let shoppingListIdentifier = "identifier"
    public var topViewHeader: TopViewHeader?
    
    public lazy var shoppingListView: BaseTableView = {
        let tv = BaseTableView()
        tv.backgroundColor = .systemPink
        tv.delegate = self
        tv.dataSource = self
        tv.register(TopViewCell.self, forCellReuseIdentifier: shoppingListIdentifier)
        tv.bounces = false
        
        let headerFrame = CGRect(x: 0, y: 0, width: view.frame.width,  height: 230)
        topViewHeader = TopViewHeader(frame: headerFrame)
        topViewHeader?.delegate = self
        
        tv.tableHeaderView = topViewHeader
        return tv
    }()
    
    public var selectedCellNumber = 0
    
    public lazy var newItemInputView: CustomInputView = {
        let view = CustomInputView()
        view.delegate = self
        return view
    }()
    
    public var categeoryBar = CategeoryBar()
    public var selectedCategoryImageUrl: String = ""
    
    public var spendingType: SpendingType = .fixed
    
    public lazy var categoryListView: CategoryListView = {
        let view = CategoryListView()
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.delegate = self
        return view
    }()
    
    public let backgroundView = UIView.createBackgroundView()
    public lazy var categoryViewHeight: CGFloat = view.frame.height - 300 - Dimension.safeAreaTopHeight
    
    public lazy var customAlert: CustomAlert = {
        let alert = CustomAlert()
        alert.delegate = self
        alert.alpha = 0
        return alert
    }()
    
    private var allItems: [Item] = []
    public var selectedItems: [Item] = []
    
    public  let inputCloseButtonHeight: CGFloat = 50
    private let inputHeight: CGFloat = 120
    
    public var shoppingListViewTopConstraint: NSLayoutConstraint?
    public var shoppingListViewBottomConstraint : NSLayoutConstraint?
    public var newItemInputViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCategories()
        fetchBudget()
        configureUI()
        setupConstraint()
        keyboardNotification()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let isCategoryListOpen = categoryListView.frame.origin.y < view.frame.height
        let isAlertShowing = customAlert.alpha == 1
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.backgroundView.alpha = 0
            
            if isCategoryListOpen {
                self.categoryListView.frame.origin.y = self.view.frame.height
                
            } else if isAlertShowing {
                self.customAlert.alpha = 0
            }
        }
    }
    
    // MARK: - API
    
    func uploadNewCategory(image: UIImage) {
        
        CategoryService.uploadCategory(image: image) { imageUrl in
            self.categeoryBar.reloadCollectionViewAfterNewCategorySelected(imageUrl: imageUrl)
        }
    }
    
    func fetchCategories() {
        CategoryService.fetchCategories { categories in
            guard let firstCategory = categories.first else { return }
            self.selectedCategoryImageUrl = firstCategory.imageUrl
            self.categeoryBar.reloadCollectionViewAfterCategoryFetched(categories: categories)
            
            self.fetchItem()
        }
    }
    
    func uploadItem(data: [String: Any]) {
        
        ItemService.uploadItem(data: data) { item in
            self.allItems.append(item)
            self.showSelectedList()
            
            if  self.selectedItems.count > 0 {
                let index = IndexPath(row: self.selectedItems.count - 1, section: 0)
                self.shoppingListView.scrollToRow(at: index, at: .bottom, animated: true)
            }
            
//            if item.isChecked { self.changeSpendingSum() }
        }
    }
    
    func fetchItem() {
        ItemService.fetchItem { items in
            self.allItems = items
            self.showSelectedList()
        }
    }
    
    func editItem(item: Item) {
        ItemService.editItem(item: item) { error in
            if let error = error {
                print("failed to edit item: \(error.localizedDescription)")
                return
            }
            
            self.shoppingListView.reloadData()
            self.dismissAlert()
        }
    }
    
    func changeCheckValue(item: Item) {
        
        ItemService.changeCheckValue(item: item) { error in
            if let error = error {
                print("failed to change checke value: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func uploadBudget(budgetInfo: BudgetInfo) {
        
        BudgetService.uploadSum(sumInfo: budgetInfo) { error in
            if let error = error {
                print("failed to upload budget: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func fetchBudget() {
        BudgetService.fetchSum { budget in
            self.topViewHeader?.configureBudget(budget: budget)
        }
    }
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(newItemInputView)
        newItemInputView.anchor(left: view.leftAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                right: view.rightAnchor,
                                height: inputHeight)
        
        view.addSubview(shoppingListView)
        shoppingListView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                left: view.leftAnchor,
                                bottom: newItemInputView.topAnchor,
                                right: view.rightAnchor,
                                paddingBottom: -inputCloseButtonHeight)
        
        view.addSubview(backgroundView)
        backgroundView.fillSuperview()
        
        view.addSubview(categoryListView)
        categoryListView.frame = CGRect(x: 0, y: view.frame.height,
                                    width: view.frame.width,
                                    height: categoryViewHeight)
        
        view.addSubview(customAlert)
        customAlert.centerX(inView: view)
        customAlert.centerY(inView: view)
        customAlert.setDimensions(height: 240, width: view.frame.width - 60)
    }
    
    func showAlert() {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.backgroundView.alpha = 1
            self.customAlert.alpha = 1
        }
    }
    
    func dismissAlert() {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.view.endEditing(true)
            self.backgroundView.alpha = 0
            self.customAlert.alpha = 0
        }
    }
    
    func changeSpendingSum(item: Item) {
        var prices: [Int] = []
        
        allItems.forEach { item in
            if item.isChecked {
                prices.append(item.price)
            }
        }
        var sum = prices.reduce(0) { $0 + $1 }
        if !item.isChecked { sum -= item.price }
        
        self.topViewHeader?.setSpendingPriceLabel(price: sum)
    }
    
    func showSelectedList() {
        self.selectedItems = []
        
        allItems.forEach { item in
            if item.categoryUrl == selectedCategoryImageUrl &&
                item.spendingType == self.spendingType.text {
                self.selectedItems.append(item)
            }
        }
        
        self.shoppingListView.reloadData()
    }
}

