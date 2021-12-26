import UIKit

// MARK: - UITableViewDataSource

extension SavingTopViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SavingViewCell
        cell.viewModel = SavingViewModel(saving: savings[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SavingTopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = SavingMonthViewController(savings: savings)
        navigationController?.pushViewController(vc, animated: true)
    }
}
