import UIKit

protocol TopViewHeaderDelegate {
    func showIncomeView()
    func showSavingView()
    func changeSegmentedValue(spendingType: SpendingType)
    func changeSavingValue(savingValue: Int)
}

struct CalculateInfo {
    let income: Int
    let spending: Int
}

class TopViewHeader: UIView {
    
    // MARK: - Properties
    
    public var delegate: TopViewHeaderDelegate?
    
    private var incomePriceLabel = UILabel()
    private var spendingPriceLabel = UILabel()
    private var savingPriceLabel = UILabel()
    
    private let monthLabelText = DateFormatter.titleMonth(date: Date())
    private lazy var monthLabel = UILabel.createBoldFontLabel(text: monthLabelText, size: 30)
    private lazy var incomeStackView = createStackView(moneyType: .income, isIncome: true)
    private lazy var spendingStackView = createStackView(moneyType: .spending, isIncome: false)
    private lazy var savingStackView = createStackView(moneyType: .saving, isIncome: false)
    private lazy var minusSymbol = createSymbolLabel(symbol: "-")
    private lazy var equalSymbol = createSymbolLabel(symbol: "=")
    
    private let savingButton = UIButton.createImageButton(image: #imageLiteral(resourceName: "close"), target: self, selector: #selector(didTapHistoryButton))
    
    public let categoryViewIdentifier = "identifier"
    private lazy var categoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: categoryViewIdentifier)
        return cv
    }()
    
    private let triangleView = TriangleView()
    
    private let segmentBackgroundView = UIView()
    private lazy var segmentControl: CustomSegmentControl = {
        let cs = CustomSegmentControl()
        cs.delegate = self
        cs.layer.cornerRadius = 35
        cs.layer.borderWidth = 1.5
        cs.layer.borderColor = UIColor.white.cgColor
        return cs
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapIncome() {
        delegate?.showIncomeView()
    }
    
    @objc func didTapHistoryButton() {
        delegate?.showSavingView()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .customYellow()
        
        addSubview(monthLabel)
        monthLabel.anchor(top: safeAreaLayoutGuide.topAnchor,
                          paddingTop: Dimension.safeAreaTop)
        monthLabel.centerX(inView: self)
        
        let stackView = UIStackView(arrangedSubviews: [incomeStackView,
                                                       minusSymbol,
                                                       spendingStackView,
                                                       equalSymbol,
                                                       savingStackView])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        addSubview(stackView)
        stackView.anchor(top: monthLabel.bottomAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         paddingTop: 20,
                         paddingLeft: 20,
                         paddingRight: 20,
                         height: 50)
        
        addSubview(triangleView)
        triangleView.backgroundColor = .customYellow()
        triangleView.anchor(top: stackView.bottomAnchor,
                            paddingTop: 10)
        triangleView.centerX(inView: self)
        triangleView.setDimensions(height: 30, width: 30)
        
        addSubview(segmentBackgroundView)
        segmentBackgroundView.backgroundColor = .customNavyBlue()
        segmentBackgroundView.anchor(top: triangleView.bottomAnchor,
                                     left: leftAnchor,
                                     right: rightAnchor,
                                     height: 110)
        
        addSubview(segmentControl)
        segmentControl.anchor(top: triangleView.bottomAnchor,
                              paddingTop: 30)
        segmentControl.centerX(inView: self)
        segmentControl.setDimensions(height: 70, width: 200)
        
        addSubview(savingButton)
        savingButton.anchor(right: rightAnchor, paddingRight: frame.width - (frame.width - 150 / 4))
        savingButton.centerY(inView: monthLabel)
        savingButton.setDimensions(height: 50, width: 50)
    }
    
    func createStackView(moneyType: MoneyType, isIncome: Bool) -> UIStackView {
        
        let priceLabel = UILabel()
        
        switch moneyType {
        case .income:
            incomePriceLabel = priceLabel
        case .spending:
            spendingPriceLabel = priceLabel
        case .saving:
            savingPriceLabel = priceLabel
        }
        
        priceLabel.text = "￥ 000"
        priceLabel.font = .digitalFont(size: 18)
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.abraham(size: 13), .kern: 2]
        titleLabel.attributedText = NSAttributedString(string: moneyType.title, attributes: attributes)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stackView.axis = .vertical
        
        if isIncome {
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapIncome))
            stackView.addGestureRecognizer(tap)
        }
        
        return stackView
    }
    
    func createSymbolLabel(symbol: String) -> UILabel {
        let label = UILabel()
        label.text = symbol
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }
    
    func setIncomePriceLabel(price: Int) {
        incomePriceLabel.text = "￥ \(price)"
        calculateSaving(fromInput: true)
    }
    
    func setSpendingPriceLabel(price: Int) {
        spendingPriceLabel.text = "￥ \(price)"
        calculateSaving(fromInput: false)
    }
    
    func calculateSaving(fromInput: Bool) {
        guard let budgetInfo = budgetStringToInt() else { return }
        
        let saving = budgetInfo.income - budgetInfo.spending
        savingPriceLabel.text = "￥ \(saving)"
        
        delegate?.changeSavingValue(savingValue: saving)
    }
    
    func budgetStringToInt() -> CalculateInfo? {
        
        guard let incomeString = incomePriceLabel.text?
                .replacingOccurrences(of: "￥ 000,000", with: "0")
                .replacingOccurrences(of: "￥ ", with: "") else { return nil }
        
        guard let spendingString = spendingPriceLabel.text?
                .replacingOccurrences(of: "￥ 000,000", with: "0")
                .replacingOccurrences(of: "￥ ", with: "") else { return nil }
        
        guard let income = Int(incomeString) else { return nil }
        guard let spending = Int(spendingString) else { return nil }
        
        return CalculateInfo(income: income, spending: spending)
    }
}
