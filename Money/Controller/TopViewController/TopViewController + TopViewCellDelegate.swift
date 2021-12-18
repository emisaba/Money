import UIKit

extension TopViewController: TopViewCellDelegate {
    func checkValue(item: Item) {
        changeCheckValue(item: item)
        
        self.changeSpendingSum(item: item)
    }
}
