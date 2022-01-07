import UIKit

class SavingTopViewController: UIViewController {
    
    // MARK: - Properties
    
    public let titleLabel = UILabel.createBoldFontLabel(text: "Saving", size: 26)
    private let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "arrow-left"), target: self, selector: #selector(didTapCloseButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SavingViewCell.self, forCellReuseIdentifier: identifier)
        return tv
    }()
    
    public var savings: [Saving] = []
    
    // MARK: - LifeCycle
    
    init(savings: [Saving]) {
        self.savings = savings
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Action
    
    @objc func didTapCloseButton() {
        navigationController?.popViewController(animated: true)
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
        
        view.addSubview(tableView)
        tableView.anchor(top: titleLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20)
    }
}
