import UIKit

extension TopViewController: CustomAlertDelegate {
    
    func didTapOkButton(alert: CustomAlert) {
        guard let itemInfo = alert.itemInfo() else { return }
        
        selectedItems[selectedCellNumber].name = itemInfo.name
        selectedItems[selectedCellNumber].price = itemInfo.price
        
        editItem(item: selectedItems[selectedCellNumber])
    }
    
    func didTapCancelButton() {
        
    }
}
