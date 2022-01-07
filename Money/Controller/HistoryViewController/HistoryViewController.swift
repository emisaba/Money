import UIKit

class HistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    public let mainImageView = UIButton.createImageView(image: #imageLiteral(resourceName: "add"), radius: 60)
    public let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "close"), target: self, selector: #selector(didTapCloseButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(HistoryViewCell.self, forCellReuseIdentifier: identifier)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0)
        return tv
    }()
    
    private let registerButton: UIButton = {
        let registerButton = UIButton.createTextButton(text: "register", target: self, selector: #selector(didTapRegisterButton))
        registerButton.layer.cornerRadius = 30
        registerButton.backgroundColor = .customYellow()
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 26), .kern: 5, .foregroundColor: UIColor.customLightNavyBlue()]
        let attributedTitle = NSAttributedString(string: "Register", attributes: attributes)
        registerButton.setAttributedTitle(attributedTitle, for: .normal)
        return registerButton
    }()
    
    public var heroItem: UIButton?
    
    public var historyItems: [HistoryItem] = []
    public var selectedHistoryItems: [HistoryItem] = []
    
    public var completion: (([HistoryItem]) -> Void)?
    
    // MARK: - LifeCycle
    
    init(image: UIImage, historyItems: [HistoryItem]) {
        self.mainImageView.setImage(image, for: .normal)
        self.historyItems = historyItems
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - API
    
    func incrementHistoryItemCount() {
        HistoryService.incrementCount(selectItems: selectedHistoryItems) { error in
            if let error = error {
                print("failed to increment: \(error.localizedDescription)")
                return
            }
            
            self.completion?(self.selectedHistoryItems)
            self.dismiss(animated: true) {
                self.heroItem?.hero.id = ""
            }
        }
    }
    
    // MARK: - Action
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true) {
            self.heroItem?.hero.id = ""
        }
    }
    
    @objc func didTapRegisterButton() {
        incrementHistoryItemCount()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .customNavyBlue()
        
        view.addSubview(mainImageView)
        mainImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             paddingTop: 10)
        mainImageView.setDimensions(height: 120, width: 120)
        mainImageView.centerX(inView: view)
        mainImageView.contentEdgeInsets = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        mainImageView.backgroundColor = .customYellow()
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           right: view.rightAnchor,
                           paddingTop: 10,
                           paddingRight: 20)
        closeButton.setDimensions(height: 60, width: 60)
        
        view.addSubview(tableView)
        tableView.anchor(top: mainImageView.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20)
        
        view.addSubview(registerButton)
        registerButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        registerButton.setDimensions(height: 60, width: view.frame.width - 100)
        registerButton.centerX(inView: view)
    }
}

