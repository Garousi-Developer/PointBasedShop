import SafariServices
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
    var profile: Profile!
    
    var isFirstTime = true
    
    var interactionAnimator: UIViewPropertyAnimator!
    var interactionAnimationDuration = durations(.interaction)
    var reverseInteractionAnimator: UIViewPropertyAnimator!
    var interactionAnimationIsReversible = false
    
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

extension ProfileTableController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsList = [4, 2, 9]
        
        return numberOfRowsList[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titles = [
            [texts(.userLevelAndPoints), texts(.favorites), texts(.inviteYourFriendsAndEarnPoints), texts(.logout)],
            [texts(.language), texts(.profileSettings)],
            [texts(.faq), texts(.howItWorks), texts(.aboutUs), texts(.contactUs), texts(.support), texts(.userAgreement), texts(.privacyPolicy), texts(.share)]
        ]
        
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "points", for: indexPath) as! PointsProfileTableCell
            var userLevel: LocalizedText!
            switch profile.userLevel {
            case "bronze":
                userLevel = texts(.bronzeUser)
                cell.userLevelLabel.textColor = colors(.bronze)
            case "silver":
                userLevel = texts(.silverUser)
                cell.userLevelLabel.textColor = colors(.lightAsset)
            case "golden":
                userLevel = texts(.goldenUser)
                cell.userLevelLabel.textColor = colors(.primary)
            default:
                break
            }
            
            cell.optionLabel.localizedText = titles[indexPath.section][indexPath.row]
            cell.userLevelLabel.localizedText = userLevel
            cell.pointsLabel.text = languageIsPersian ?
                "\(Int(Double(profile.userPoints)!).priceFormatted) \(texts(.points).persian)" :
                "\(Int(Double(profile.userPoints)!).priceFormatted) \(texts(.points).english)"
            
            return cell
        case IndexPath(row: 3, section: 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "logout", for: indexPath) as! LogoutProfileTableCell
            
            cell.optionLabel.localizedText = titles[indexPath.section][indexPath.row]
            cell.nameLabel.text = languageIsPersian ?
                "\(texts(.signedInAs).persian) \(profile.firstName) \(profile.lastName)" :
                "\(texts(.signedInAs).english) \(profile.firstName) \(profile.lastName)"
            
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
extension ProfileTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return fonts(.extraLarge).firstLineHeight
        }
        else {
            return fonts(.extraLarge).firstLineHeight + scale * 2 * 12
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titles = [texts(.hello), texts(.settings), texts(.general)]
        let view = View()
        let titleLabel = Label()
        
        titleLabel.font = fonts(.extraLarge)
        titleLabel.textColor = colors(.darkAsset)
        if section == 0 {
            titleLabel.text = languageIsPersian ? "\(titles[section].persian) \(profile.firstName)" : "\(titles[section].english) \(profile.firstName)"
        }
        else {
            titleLabel.localizedText = titles[section]
        }
        
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
        case IndexPath(row: 1, section: 0):
            viewController.navigateTo(.favorites)
        case IndexPath(row: 2, section: 0):
            viewController.navigateTo(.invite)
        case IndexPath(row: 3, section: 0):
            UserDefaults.standard.removeObject(forKey: "skipped")
            UserDefaults.standard.removeObject(forKey: "token")
            
            UIView.transition(
                with: UIApplication.shared.keyWindow!,
                duration: 2 * durations(.textField),
                options: .transitionFlipFromLeft,
                animations: {
                    UIApplication.shared.keyWindow!.rootViewController = navigationDestinations(.login, transferringData: nil)
                },
                completion: nil
            )
        case IndexPath(row: 1, section: 1):
            viewController.navigateTo(.profileSettings)
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
extension ProfileTableController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if interactionAnimationIsReversible {
            interactionAnimationIsReversible = false
            reverseInteractionAnimator.startAnimation()
        }
    }
}

extension ProfileTableController {
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
