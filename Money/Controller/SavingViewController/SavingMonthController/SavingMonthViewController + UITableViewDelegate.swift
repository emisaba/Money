import UIKit

// MARK: - UITableViewDataSource

extension SavingMonthViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SavingMonthViewCell
        cell.viewModel = SavingMonthViewModel(saving: savingItems[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SavingMonthViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = SavingMonthViewModel(saving: savingItems[indexPath.row])
        let vc = SavingCategoryViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
