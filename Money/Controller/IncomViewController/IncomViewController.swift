import UIKit

class IncomeViewController: UIViewController {
    
    // MARK: - Properties
    
    public let titleLabel = UILabel.createBoldFontLabel(text: "Income", size: 26)
    
    private let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "close"), target: self, selector: #selector(didTapCloseButton))
    private let editButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "edit"), target: self, selector: #selector(didTapEditButton))
    private let addButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "add-line"), target: self, selector: #selector(didTapAddButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(IncomeViewCell.self, forCellReuseIdentifier: identifier)
        return tv
    }()
    
    public let backgroundView = UIView.createBackgroundView()
    public lazy var incomeAlert: CustomAlert = {
        let alert = CustomAlert()
        alert.delegate = self
        alert.alpha = 0
        return alert
    }()
    
    public var priceSum: ((Int) -> Void)?
    
    public var incomes: [Income] = [] {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchIncomes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismissAlert()
    }
    
    // MARK: - API
    
    func registerIncome(incomeInfo: IncomeInfo) {
        
        IncomeService.registerIncome(incomeInfo: incomeInfo) { error in
            if let error = error {
                print("failed to upload income: \(error.localizedDescription)")
                return
            }
            
            self.fetchIncomes()
            self.dismissAlert()
            self.view.endEditing(true)
        }
    }
    
    func fetchIncomes() {
        IncomeService.fetchIncome { incomes in
            self.incomes = incomes
        }
    }
    
    func editIncome(incomeInfo: IncomeInfo, incomeID: String) {
        
        IncomeService.editIncome(incomeInfo: incomeInfo, incomeID: incomeID) { error in
            if let error = error {
                print("faild to edit income: \(error.localizedDescription)")
                return
            }
            
            self.fetchIncomes()
            self.dismissAlert()
        }
    }
    
    // MARK: - Action
    
    @objc func didTapCloseButton() {
        let extractPrice = incomes.map { $0.price }
        let incomeSome = extractPrice.reduce(0) { $0 + $1 }
        priceSum?(incomeSome)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapEditButton() {
        
    }
    
    @objc func didTapAddButton() {
        incomeAlert.addIncome()
        showAlert()
    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        view.backgroundColor = .customNavyBlue()
        
        view.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          paddingTop: 20)
        titleLabel.setDimensions(height: 50,
                                 width: view.frame.width - 170)
        titleLabel.centerX(inView: view)
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           paddingTop: 20,
                           paddingLeft: 10)
        closeButton.setDimensions(height: 50, width: 50)
        
        let stackView = UIStackView(arrangedSubviews: [editButton, addButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20,
                         paddingRight: 10)
        stackView.setDimensions(height: 50, width: 100)
        
        view.addSubview(tableView)
        tableView.anchor(top: titleLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20)
        
        view.addSubview(backgroundView)
        backgroundView.fillSuperview()
        
        view.addSubview(incomeAlert)
        incomeAlert.centerX(inView: view)
        incomeAlert.centerY(inView: view)
        incomeAlert.setDimensions(height: 240, width: view.frame.width - 60)
    }
    
    func showAlert() {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.backgroundView.alpha = 1
            self.incomeAlert.alpha = 1
        }
    }
    
    func dismissAlert() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.backgroundView.alpha = 0
            self.incomeAlert.alpha = 0
        }
    }
}
