import UIKit

extension TopViewController: TopViewHeaderDelegate {
    func showIncomeView() {
        
        let vc = IncomeViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.isHeroEnabled = true
        vc.priceSum = { sum in
            self.topViewHeader?.setIncomePriceLabel(price: "￥ \(sum)")
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    func showSavingView() {
        let vc = SavingViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.isHeroEnabled = true
        
        present(vc, animated: true, completion: nil)
    }
}
