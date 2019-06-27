import UIKit
import BetterSegmentedControl
import SnapKit

class ProfileTableController: SecondaryController {
    var tableView: TableView!
    var data: [Any] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(viewController: ViewController, tableView: TableView) {
        super.init(viewController: viewController)
        
        self.tableView = tableView
    }
}

extension ProfileTableController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsList = [4, 2, 7]
        
        return numberOfRowsList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titles = [
            [texts(.userLevelAndPoints), texts(.favorites), texts(.inviteYourFriendsAndEarnPoints), texts(.logout)],
            [texts(.language), texts(.profileSettings)],
            [texts(.howItWorks), texts(.aboutUs), texts(.contactUs), texts(.support), texts(.userAgreement), texts(.privacyPolicy)]
        ]
        
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "points", for: indexPath) as! PointsProfileTableCell
            
            cell.optionLabel.text = titles[indexPath.section][indexPath.row]
            cell.userLevelLabel.text = "کاربر طلایی"
            cell.pointsLabel.text = "۱٫۰۰۰ امتیاز"
            
            return cell
        case IndexPath(row: 3, section: 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "logout", for: indexPath) as! LogoutProfileTableCell
            
            cell.optionLabel.text = titles[indexPath.section][indexPath.row]
            cell.nameLabel.text = "وارد شده به عنوان آرمان گروسی"
            
            return cell
        case IndexPath(row: 0, section: 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "language", for: indexPath) as! LanguageProfileTableCell
            
            cell.optionLabel.text = titles[indexPath.section][indexPath.row]
            
            return cell
        case IndexPath(row: 6, section: 2):
            let cell = tableView.dequeueReusableCell(withIdentifier: "social", for: indexPath) as! SocialProfileTableCell
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "option", for: indexPath) as! ProfileTableCell
            
            cell.optionLabel.text = titles[indexPath.section][indexPath.row]
            
            return cell
        }
    }
}
extension ProfileTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return fonts(.extraLarge).firstLineHeight + scale * 2 * 12
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titles = ["\(texts(.hello)) آرمان", texts(.settings), texts(.general)]
        let view = View()
        let titleLabel = Label()
        
        titleLabel.font = fonts(.extraLarge)
        titleLabel.textColor = colors(.darkAsset)
        titleLabel.text = titles[section]
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(scale * 12)
            make.trailing.equalToSuperview().offset(scale * -12)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 1, section: 0):
            viewController.navigateTo(.favorites)
        default:
            break
        }
    }
}
