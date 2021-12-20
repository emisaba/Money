import UIKit

extension HistoryViewController: HistoryViewCellDelegate {
    
    func selectItem(cellNumber: Int, shouldRemove: Bool) {
        let selectedItemId = historyItems[cellNumber].itemID
 
        if shouldRemove {
            selectedHistoryItems.removeAll(where: { $0.itemID == selectedItemId })
        } else {
            selectedHistoryItems.append(historyItems[cellNumber])
        }
    }
}
