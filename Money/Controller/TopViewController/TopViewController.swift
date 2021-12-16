import UIKit

class TopViewController: UIViewController {
    
    // MARK: - Properties
    
    public let shoppingListIdentifier = "identifier"
    public var topViewHeader: TopViewHeader?
    
    public lazy var shoppingListView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(TopViewCell.self, forCellReuseIdentifier: shoppingListIdentifier)
        
        let headerFrame = CGRect(x: 0, y: 0, width: view.frame.width,  height: 230)
        topViewHeader = TopViewHeader(frame: headerFrame)
        topViewHeader?.delegate = self
        
        tv.tableHeaderView = topViewHeader
        return tv
    }()
    
    public let newItemInputView = CustomInputView()
    
    public let categoryListView: CategoryListView = {
        let view = CategoryListView()
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.4
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
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
    
    public  let inputCloseButtonHeight: CGFloat = 50
    private let inputHeight: CGFloat = 120
    
    public var shoppingListViewTopConstraint: NSLayoutConstraint?
    public var shoppingListViewBottomConstraint : NSLayoutConstraint?
    public var newItemInputViewBottomConstraint: NSLayoutConstraint?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    // MARK: - Action
    
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
        
        view.addSubview(backgroundView)
        backgroundView.fillSuperview()
        
        view.addSubview(customAlert)
        customAlert.centerX(inView: view)
        customAlert.centerY(inView: view)
        customAlert.setDimensions(height: 240, width: view.frame.width - 60)
    }
}

