import UIKit

class SavingViewController: UIViewController {
    
    // MARK: - Properties
    
    public let titleLabel = UILabel.createBoldFontLabel(text: "Saving", size: 26)
    private let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "history"), target: self, selector: #selector(didTapCloseButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SavingViewCell.self, forCellReuseIdentifier: identifier)
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
    
    // MARK: - Helper
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.backgroundColor = .white
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
