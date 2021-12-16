import UIKit

// MARK: - UITableViewDataSource

extension TopViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categeoryBar = CategeoryBar()
        categeoryBar.categeoryBarDelegate = self
        return categeoryBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingListIdentifier, for: indexPath) as! TopViewCell
        cell.backgroundColor = .systemPink
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.backgroundView.alpha = 1
            self.customAlert.alpha = 1
        }
    }
}
