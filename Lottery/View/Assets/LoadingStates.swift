import UIKit
import NVActivityIndicatorView
import SnapKit

extension Button {
    func setLoadingState(_ loadingState: LoadingState, didComplete: (() -> Void)? = nil) {
        switch loadingState {
        case .loading:
            animateLoading(didComplete: didComplete)
        case .successful:
            animateBack()
        case .failed(_, _, _, _):
            animateBack()
        }
    }
    
    private func animateLoading(didComplete: (() -> Void)? = nil) {
        if firstInteractionAnimationType == .bounce {
            if let widthConstraint = widthConstraint, let heightConstraint = heightConstraint {
                let width = widthConstraint.constant
                let height = heightConstraint.constant
                widthHolder = width
                heightHolder = height
                
                if width > height {
                    NSLayoutConstraint.deactivate([widthConstraint, heightConstraint])
                }
                else {
                    NSLayoutConstraint.deactivate([widthConstraint, heightConstraint])
                    self.widthConstraint = nil
                    self.heightConstraint = nil
                }
                snp.makeConstraints { make in
                    make.width.height.equalTo(height)
                }
            }
            else {
                snp.updateConstraints { make in
                    make.width.equalTo(heightHolder)
                }
            }
        }
        
        titleHolder = title(for: .normal)
        imageHolder = image(for: .normal)
        setTitle(nil, for: .normal)
        setImage(nil, for: .normal)
        
        UIView.animate(withDuration: durations(.interaction), animations: {
            self.layoutIfNeeded()
        })
        { _ in
            self.loadingView = NVActivityIndicatorView(
                frame: CGRect(),
                type: .ballRotateChase,
                color: colors(.white),
                padding: 4
            )
            self.addSubview(self.loadingView)
            self.loadingView!.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            self.loadingView.startAnimating()
            
            if let didComplete = didComplete {
                didComplete()
            }
        }
    }
    private func animateBack() {
        loadingView?.removeFromSuperview()
        
        if firstInteractionAnimationType == .bounce {
            snp.updateConstraints { make in
                make.width.equalTo(widthHolder)
            }
        }
        UIView.animate(withDuration: durations(.interaction), animations: {
            self.superview!.layoutIfNeeded()
        })
        { _ in
            self.setImage(self.imageHolder, for: .normal)
            self.setTitle(self.titleHolder, for: .normal)
        }
    }
}
extension UIViewController {
    @objc private func retry(_ sender: Button) {
//        sender.setLoadingState(.loading) {
//            request(
//                sender.requestHolder.endPointName,
//                didSucceed: sender.requestHolder.didSucceed,
//                didFail: sender.requestHolder.didFail
//            )
//        }
    }
    
    func setLoadingState(_ loadingState: LoadingState) {
        switch loadingState {
        case .loading:
            animateLoading()
        case .successful:
            animateContent()
        case .failed(let reason, let requestHolder, let noContentIcon, let noContentText):
            switch reason! {
            case .noInternet:
                animateNoInternet(requestHolder: requestHolder!)
            case .noContent:
                animateNoContent(icon: noContentIcon!, localizedText: noContentText!)
            }
        }
    }
    
    private func animateLoading() {
        view.removeSubview(withLayerName: "noInternet")
        view.removeSubview(withLayerName: "noContent")
        
        for subview in view.subviews {
            if subview.layer.name != "navigationShadow" {
                subview.alpha = 0
            }
        }
        
        let loadingView = NVActivityIndicatorView(
            frame: CGRect(),
            type: .ballRotateChase,
            color: colors(.primary),
            padding: 0
        )
        loadingView.layer.name = "loading"
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(48)
        }
        loadingView.startAnimating()
    }
    private func animateContent() {
        view.removeSubview(withLayerName: "loading")
        view.removeSubview(withLayerName: "noInternet")
        view.removeSubview(withLayerName: "noContent")
        
        for subview in view.subviews {
            subview.fadeIn()
        }
    }
    private func animateNoInternet(requestHolder: RequestHolder) {
        view.removeSubview(withLayerName: "loading")
        
        if let noInternetStackView = view.subview(withLayerName: "noInternet") as? StackView {
            let retryButton = noInternetStackView.subview(withLayerName: "retry") as! Button
            retryButton.setLoadingState(.failed(reason: nil, requestHolder: nil, noContentIcon: nil, noContentText: nil))
        }
        else {
            let noInternetImageView = ImageView(image: #imageLiteral(resourceName: "noInternet"))
            noInternetImageView.layer.name = "noInternetImageView"
            noInternetImageView.tintColor = colors(.asset)
            
            let noInternetLabel = Label()
            noInternetLabel.layer.name = "noInternetLabel"
            noInternetLabel.font = fonts(.semiLarge)
//            noInternetLabel.text = Text.noInternet.rawValue
            noInternetLabel.textColor = colors(.asset)
            
            let retryButton = Button(type: .custom)
            retryButton.layer.name = "retry"
            retryButton.backgroundColor = colors(.primary)
//            retryButton.dynamicTitle = Text.retry.rawValue
            retryButton.titleLabel!.font = fonts(.medium)
            retryButton.setTitleColor(colors(.white), for: .normal)
            retryButton.firstInteractionAnimationType = InteractionAnimation.bounce
            retryButton.addTarget(self, action: #selector(retry(_:)), for: .touchUpInside)
//            retryButton.requestHolder = requestHolder
            
            let noInternetStackView = StackView(arrangedSubviews: [noInternetImageView, noInternetLabel, retryButton])
            noInternetStackView.layer.name = "noInternet"
            noInternetStackView.axis = .vertical
            noInternetStackView.alignment = .center
            noInternetStackView.spacing = 16
            noInternetStackView.setCustomSpacing(24, after: noInternetLabel)
            
            view.addSubview(noInternetStackView)
            retryButton.snp.makeConstraints { make in
//                retryButton.widthConstraint = make.width.equalTo(view.snp.width).dividedBy(2).constraint.layoutConstraints.first!
//                retryButton.aspectRatioConstraint = make.height.equalTo(retryButton.snp.width).dividedBy(4).constraint.layoutConstraints.first!
            }
            noInternetStackView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
//            let retryWidth = retryButton.widthConstraint!.multiplier * UIScreen.main.bounds.width
//            let retryAspectRatio = retryButton.aspectRatioConstraint!.multiplier
//            let retryHeight = retryWidth * retryAspectRatio
//            retryButton.layer.cornerRadius = min(retryWidth, retryHeight) / 2
        }
    }
    private func animateNoContent(icon: UIImage, localizedText: LocalizedText) {
        view.removeSubview(withLayerName: "loading")
        view.removeSubview(withLayerName: "noInternet")
        
        let noContentImageView = ImageView(image: icon)
        noContentImageView.layer.name = "noContentImageView"
        noContentImageView.tintColor = colors(.asset)
        
        let noContentLabel = Label()
        noContentLabel.layer.name = "noContentLabel"
        noContentLabel.font = fonts(.large)
        noContentLabel.localizedText = localizedText
        noContentLabel.textColor = colors(.asset)
        
        let noContentStackView = StackView(arrangedSubviews: [noContentImageView, noContentLabel])
        noContentStackView.layer.name = "noContent"
        noContentStackView.axis = .vertical
        noContentStackView.alignment = .center
        noContentStackView.spacing = 16
        
        view.addSubview(noContentStackView)
        noContentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

enum LoadingState {
    case loading
    case successful
    case failed(reason: LoadingFailureReason!, requestHolder: RequestHolder!, noContentIcon: UIImage!, noContentText: LocalizedText!)
}
enum LoadingFailureReason {
    case noInternet
    case noContent
}
