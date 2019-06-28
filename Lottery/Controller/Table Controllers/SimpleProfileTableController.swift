import UIKit
import BetterSegmentedControl
import SnapKit

class SimpleProfileTableController: SecondaryController {
    var tableView: TableView!
    var data: [Any] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    @objc func register() {
        delay(durations(.epsilon)) {
            self.viewController.navigateTo(.registerFirstStep)
        }
    }
    @objc func login() {
        delay(durations(.epsilon)) {
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
            
            self.viewController.navigationController!.pushViewController(loginViewController, animated: true)
        }
    }
    
    init(viewController: ViewController, tableView: TableView) {
        super.init(viewController: viewController)
        
        self.tableView = tableView
    }
}

extension SimpleProfileTableController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsList = [1, 1, 7]
        
        return numberOfRowsList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titles = [
            [texts(.register)],
            [texts(.language)],
            [texts(.howItWorks), texts(.aboutUs), texts(.contactUs), texts(.support), texts(.userAgreement), texts(.privacyPolicy)]
        ]
        
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "register", for: indexPath) as! RegisterProfileTableCell
            
            cell.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
            cell.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
            
            return cell
        case IndexPath(row: 0, section: 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "language", for: indexPath) as! LanguageProfileTableCell
            
            cell.optionLabel.localizedText = titles[indexPath.section][indexPath.row]
            
            return cell
        case IndexPath(row: 6, section: 2):
            let cell = tableView.dequeueReusableCell(withIdentifier: "social", for: indexPath) as! SocialProfileTableCell
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "option", for: indexPath) as! ProfileTableCell
            
            cell.optionLabel.localizedText = titles[indexPath.section][indexPath.row]
            
            return cell
        }
    }
}
extension SimpleProfileTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return fonts(.extraLarge).firstLineHeight + scale * 2 * 12
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titles = [texts(.welcome), texts(.settings), texts(.general)]
        let view = View()
        let titleLabel = Label()
        
        titleLabel.font = fonts(.extraLarge)
        titleLabel.textColor = colors(.darkAsset)
        titleLabel.localizedText = titles[section]
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(scale * -12)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
