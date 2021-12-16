import UIKit

extension IncomeViewController: CustomAlertDelegate {
    
    func didTapOkButton(alert: CustomAlert) {
        guard let incomeInfo = alert.incomeInfo() else { return }
        registerIncome(incomeInfo: incomeInfo)
    }
    
    func didTapCancelButton() {
        
    }
}
