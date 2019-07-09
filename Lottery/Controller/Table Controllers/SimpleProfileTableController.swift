import SafariServices
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
    var profile: SimpleProfile!
    
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
    @objc func goToFacebookPage() {
        let url = "fb://profile/\(profile.facebook)"
        let fallbackURL = "https://facebook.com/\(profile.facebook)"
        
        openApp(withURL: url, andFallbackURL: fallbackURL)
    }
    @objc func goToInstagramPage() {
        let url = "instagram://user?username=\(profile.instagram)"
        let fallbackURL = "https://instagram.com/\(profile.instagram)"
        
        openApp(withURL: url, andFallbackURL: fallbackURL)
    }
    @objc func goToTwitterPage() {
        let url = "twitter://user?screen_name=\(profile.twitter)"
        let fallbackURL = "https://twitter.com/\(profile.twitter)"
        
        openApp(withURL: url, andFallbackURL: fallbackURL)
    }
    @objc func goToLinkedinPage() {
        let url = "linkedin://profile/\(profile.linkedin)"
        let fallbackURL = "https://linkedin.com/in/\(profile.linkedin)"
        
        openApp(withURL: url, andFallbackURL: fallbackURL)
    }
    @objc func goToYoutubePage() {
        let url = "youtube://\(profile.youtube)"
        let fallbackURL = "https://youtube.com/\(profile.youtube)"
        
        openApp(withURL: url, andFallbackURL: fallbackURL)
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
        let numberOfRowsList = [1, 1, 9]
        
        return numberOfRowsList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titles = [
            [texts(.register)],
            [texts(.language)],
            [texts(.faq), texts(.howItWorks), texts(.aboutUs), texts(.contactUs), texts(.support), texts(.userAgreement), texts(.privacyPolicy), texts(.share)]
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
        case IndexPath(row: 8, section: 2):
            let cell = tableView.dequeueReusableCell(withIdentifier: "social", for: indexPath) as! SocialProfileTableCell
            
            cell.facebookButton.addTarget(self, action: #selector(goToFacebookPage), for: .touchUpInside)
            cell.instagramButton.addTarget(self, action: #selector(goToInstagramPage), for: .touchUpInside)
            cell.twitterButton.addTarget(self, action: #selector(goToTwitterPage), for: .touchUpInside)
            cell.linkedInButton.addTarget(self, action: #selector(goToLinkedinPage), for: .touchUpInside)
            cell.youtubeButton.addTarget(self, action: #selector(goToYoutubePage), for: .touchUpInside)
            
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
        if section == 0 {
            return fonts(.extraLarge).firstLineHeight
        }
        else {
            return fonts(.extraLarge).firstLineHeight + scale * 2 * 12
        }
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
            if section == 0 {
                make.centerY.equalToSuperview().offset(scale * -12)
            }
            else {
                make.centerY.equalToSuperview()
            }
            make.trailing.equalToSuperview().offset(scale * -12)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 7, section: 2):
            let activityViewController = UIActivityViewController(
                activityItems: [languageIsPersian ? texts(.shareText).persian : texts(.shareText).english],
                applicationActivities: nil
            )
            activityViewController.popoverPresentationController?.sourceView = viewController.view
            
            viewController.present(activityViewController, animated: true, completion: nil)
        default:
            if indexPath.section == 2 && indexPath.row != 8 {
                var url = "https://mallsconnect.com"
                languageIsPersian ? url.append("/fa") : url.append("/en")
                let urls = ["/faq", "/how-it-work", "/about-us", "/contact-us", "/support", "/user-agreement", "/policy"]
                url.append(urls[indexPath.row])
                
                presentSafariViewController(withURL: url)
            }
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

extension SimpleProfileTableController {
    private func presentSafariViewController(withURL urlString: String) {
        let url = URL(string: urlString)!
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.dismissButtonStyle = .close
        
        viewController.present(safariViewController, animated: true, completion: nil)
    }
    private func openApp(withURL urlString: String, andFallbackURL fallbackURLString: String) {
        let url = URL(string: urlString)!
        let fallbackURL = URL(string: fallbackURLString)!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            UIApplication.shared.open(fallbackURL, options: [:], completionHandler: nil)
        }
    }
}
