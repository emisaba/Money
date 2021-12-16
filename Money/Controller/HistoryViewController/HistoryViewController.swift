import UIKit

class HistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    public let mainImageView = UIButton.createImageView(image: #imageLiteral(resourceName: "add"), radius: 60)
    public let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "close"), target: self, selector: #selector(didTapCloseButton))
    public let registerButton = UIButton.createTextButton(text: "register", target: self, selector: #selector(didTapRegisterButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(HistoryViewCell.self, forCellReuseIdentifier: identifier)
        return tv
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Action
    
    @objc func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapRegisterButton() {
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(mainImageView)
        mainImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             paddingTop: 10)
        mainImageView.setDimensions(height: 120, width: 120)
        mainImageView.centerX(inView: view)
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           right: view.rightAnchor,
                           paddingTop: 10,
                           paddingRight: 20)
        closeButton.setDimensions(height: 60, width: 60)
        
        view.addSubview(tableView)
        tableView.anchor(top: mainImageView.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 20,
                         paddingBottom: 80)
        
        view.addSubview(registerButton)
        registerButton.anchor(left: view.leftAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              right: view.rightAnchor,
                              height: 80)
    }
}

