import UIKit

class SavingMonthViewController: UIViewController {
    
    // MARK: - Properties
    
    private let monthLabel = UILabel.createBoldFontLabel(text: "", size: 24)
    private let priceLabel = UILabel.createBoldFontLabel(text: "", size: 20)
    
    private let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "history"), target: self, selector: #selector(didTapCloseButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SavingMonthViewCell.self, forCellReuseIdentifier: identifier)
        return tv
    }()
    
    public var savingItems: [SavingMonth] = []
    
    // MARK: - LifeCycle
    
    init(savings: [Saving]) {
        
        if let saving = savings.first {
            monthLabel.text = saving.date
            priceLabel.text = "￥ \(saving.savingCost)"
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        savingInfoForMonth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Action
    
    @objc func didTapCloseButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - API
    
    func savingInfoForMonth() {
        CategoryService.fetchCategories { categories in
            
            categories.forEach { category in
                SavingService.fetchSavingForCategories(category: category.imageUrl) { items in
                    
                    let itemPrices = items.map { $0.price }
                    let priceSum = itemPrices.reduce(0) {$0 + $1}
                    let savingMonth = SavingMonth(categoryUrl: category.imageUrl, savingSum: priceSum, items: items)
                    self.savingItems.append(savingMonth)
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let titleStackView = UIStackView(arrangedSubviews: [monthLabel, priceLabel])
        titleStackView.distribution = .fillEqually
        titleStackView.axis = .vertical
        titleStackView.backgroundColor = .systemRed
        
        view.addSubview(titleStackView)
        titleStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 10,
                              height: 100)
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           paddingTop: 20,
                           paddingLeft: 10)
        closeButton.setDimensions(height: 50, width: 50)
        
        view.addSubview(tableView)
        tableView.anchor(top: titleStackView.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
}
