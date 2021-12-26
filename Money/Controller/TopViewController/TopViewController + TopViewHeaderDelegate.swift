import UIKit

extension TopViewController: TopViewHeaderDelegate {
    
    func changeSavingValue(savingValue: Int) {
        uploadSaving(savingValue: savingValue)
    }

    func changeSegmentedValue(spendingType: SpendingType) {
        self.spendingType = spendingType
        swapListCategory()
    }
    
    func showIncomeView() {
        let vc = IncomeViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.isHeroEnabled = true
        vc.priceSum = { sum in
            self.topViewHeader?.setIncomePriceLabel(price: sum)
        }
        present(vc, animated: true, completion: nil)
    }
    
    func showSavingView() {
        let vc = SavingTopViewController(savings: savings)
        vc.modalPresentationStyle = .fullScreen
//        vc.isHeroEnabled = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
