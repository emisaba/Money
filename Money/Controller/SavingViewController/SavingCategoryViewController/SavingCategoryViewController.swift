import UIKit
import SDWebImage

class SavingCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let categoryImage = UIImageView.createImageView(image: #imageLiteral(resourceName: "close"), radius: 50)
    private let priceLabel = UILabel.createBoldFontLabel(text: "", size: 30)
    
    private let closeButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "history"), target: self, selector: #selector(didTapCloseButton))
    
    public let identifier = "identifier"
    private lazy var tableView: BaseTableView = {
        let tv = BaseTableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SavingCategoryViewCell.self, forCellReuseIdentifier: identifier)
        return tv
    }()
    
    public let items: [Item]
    
    // MARK: - Lifecycle
    
    init(viewModel: SavingMonthViewModel) {
        self.items = viewModel.items
        categoryImage.sd_setImage(with: viewModel.categoryImage, completed: nil)
        priceLabel.text = "￥ \(viewModel.savingSum)"
        
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
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(categoryImage)
        categoryImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)
        categoryImage.centerX(inView: view)
        categoryImage.setDimensions(height: 100, width: 100)
        
        view.addSubview(priceLabel)
        priceLabel.anchor(top: categoryImage.bottomAnchor, paddingTop: 10)
        priceLabel.setDimensions(height: 50, width: view.frame.width)
        
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           paddingTop: 20,
                           paddingLeft: 10)
        closeButton.setDimensions(height: 50, width: 50)
        
        view.addSubview(tableView)
        tableView.anchor(top: priceLabel.bottomAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
}
