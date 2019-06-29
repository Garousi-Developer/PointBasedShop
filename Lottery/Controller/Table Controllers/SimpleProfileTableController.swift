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
    
    var isFirstTime = true
    
    var interactionAnimator: UIViewPropertyAnimator!
    var interactionAnimationDuration = durations(.interaction)
    var reverseInteractionAnimator: UIViewPropertyAnimator!
    var interactionAnimationIsReversible = false
    
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
    @objc func languageDidChange(sender: SegmentedControl) {
        switch sender.index {
        // English:
        case 0:
            UserDefaults.standard.set("english", forKey: "language")
            delay(durations(.interaction)) {
                (UIApplication.shared.delegate as! AppDelegate).launchApp(relaunch: true)
            }
        // Persian:
        case 1:
            UserDefaults.standard.set("persian", forKey: "language")
            delay(durations(.interaction)) {
                (UIApplication.shared.delegate as! AppDelegate).launchApp(relaunch: true)
            }
        default:
            break
        }
    }
    
    func animateInteraction(_ tableCell: TableCell) {
        interactionAnimator = UIViewPropertyAnimator(duration: interactionAnimationDuration, curve: .easeInOut) {
            if tableCell.backgroundColorHolder == nil {
                tableCell.backgroundColorHolder = tableCell.backgroundColor
            }
            
            tableCell.backgroundColor = colors(.highlightedPlaceholder)
        }
        
        interactionAnimator.startAnimation()
    }
    func animateInteractionReversely(_ tableCell: TableCell) {
        var reverseDelay: TimeInterval!
        if interactionAnimator.isRunning {
            reverseDelay = interactionAnimationDuration - TimeInterval(interactionAnimator.fractionComplete) * interactionAnimationDuration
        }
        else {
            reverseDelay = 0
        }
        
        reverseInteractionAnimator = UIViewPropertyAnimator(duration: interactionAnimationDuration, curve: .easeInOut) {
            tableCell.backgroundColor = tableCell.backgroundColorHolder
        }
        interactionAnimationIsReversible = true
        
        delay(reverseDelay) {
            self.reverseInteractionAnimator.startAnimation()
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
        let numberOfRowsList = [1, 1, 8]
        
        return numberOfRowsList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titles = [
            [texts(.register)],
            [texts(.language)],
            [texts(.howItWorks), texts(.aboutUs), texts(.contactUs), texts(.support), texts(.userAgreement), texts(.privacyPolicy), texts(.share)]
        ]
        
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "register", for: indexPath) as! RegisterProfileTableCell
            
            cell.registerButton.widthConstraint.constant = languageIsPersian ? scale * 50 : scale * 60
            cell.loginButton.widthConstraint.constant = languageIsPersian ? scale * 35 : scale * 45
            
            cell.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
            cell.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
            
            return cell
        case IndexPath(row: 0, section: 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: "language", for: indexPath) as! LanguageProfileTableCell
            
            cell.optionLabel.localizedText = titles[indexPath.section][indexPath.row]
            if isFirstTime {
                isFirstTime = false
                
                cell.segmentedControl.setIndex(
                    languageIsPersian ? 1 : 0,
                    animated: false
                )
            }
            
            cell.segmentedControl.addTarget(self, action: #selector(languageDidChange), for: .valueChanged)
            
            return cell
        case IndexPath(row: 7, section: 2):
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
        switch indexPath {
        case IndexPath(row: 6, section: 2):
            let activityViewController = UIActivityViewController(
                activityItems: [languageIsPersian ? texts(.shareText).persian : texts(.shareText).english],
                applicationActivities: nil
            )
            activityViewController.popoverPresentationController?.sourceView = viewController.view
            
            viewController.present(activityViewController, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let untappableIndexPaths = [
            IndexPath(row: 0, section: 0),
            IndexPath(row: 0, section: 1),
            IndexPath(row: 7, section: 2)
        ]
        
        for (i, untappableIndexPath) in untappableIndexPaths.enumerated() {
            if indexPath == untappableIndexPath {
                break
            }
            else {
                if i == untappableIndexPaths.count - 1 {
                    let tableCell = tableView.cellForRow(at: indexPath) as! TableCell
                    animateInteraction(tableCell)
                }
                else {
                    continue
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let untappableIndexPaths = [
            IndexPath(row: 0, section: 0),
            IndexPath(row: 0, section: 1),
            IndexPath(row: 7, section: 2)
        ]
        
        for (i, untappableIndexPath) in untappableIndexPaths.enumerated() {
            if indexPath == untappableIndexPath {
                break
            }
            else {
                if i == untappableIndexPaths.count - 1 {
                    let tableCell = tableView.cellForRow(at: indexPath) as! TableCell
                    animateInteractionReversely(tableCell)
                }
                else {
                    continue
                }
            }
        }
    }
}
extension SimpleProfileTableController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if interactionAnimationIsReversible {
            interactionAnimationIsReversible = false
            reverseInteractionAnimator.startAnimation()
        }
    }
}
