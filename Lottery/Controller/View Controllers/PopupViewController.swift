import UIKit
import SnapKit

class PopupViewController: ViewController {
    var type: PopupType!
    
    @objc private func login(_ sender: Button) {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: "login") as! LoginViewController
        
        present(loginViewController, animated: true, completion: nil)
    }
    @objc private func register(_ sender: Button) {
        navigateTo(.registerFirstStep)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let noContentImageView = ImageView(
            image: languageIsPersian ? #imageLiteral(resourceName: "bigCart").withHorizontallyFlippedOrientation() : #imageLiteral(resourceName: "bigCart")
        )
        if type == .favorites {
            noContentImageView.image = #imageLiteral(resourceName: "bigFavorites")
        }
        noContentImageView.layer.name = "noContentImageView"
        noContentImageView.tintColor = colors(.asset)
        
        let noContentLabel = Label()
        noContentLabel.layer.name = "noContentLabel"
        noContentLabel.font = fonts(.large)
        noContentLabel.localizedText = texts(.loginForActivation)
        noContentLabel.textColor = colors(.asset)
        
        let loginButton = Button(type: .custom)
        loginButton.layer.name = "loginButton"
        loginButton.setCornerRadius(.medium)
        loginButton.backgroundColor = colors(.primary)
        loginButton.setTitleColor(colors(.white), for: .normal)
        loginButton.setLocalizedTitle(texts(.login), for: .normal)
        loginButton.firstInteractionAnimationType = InteractionAnimation.bounce
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        let registerButton = Button(type: .custom)
        registerButton.layer.name = "registerButton"
        registerButton.setCornerRadius(.medium)
        registerButton.backgroundColor = colors(.primary)
        registerButton.setTitleColor(colors(.white), for: .normal)
        registerButton.setLocalizedTitle(texts(.register), for: .normal)
        registerButton.firstInteractionAnimationType = InteractionAnimation.bounce
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        let noContentStackView: StackView
        noContentStackView = StackView(arrangedSubviews: [noContentImageView, noContentLabel, loginButton, registerButton])
        noContentStackView.layer.name = "noContent"
        noContentStackView.axis = .vertical
        noContentStackView.alignment = .center
        noContentStackView.spacing = 16
        noContentStackView.setCustomSpacing(24, after: noContentLabel)
        noContentStackView.setCustomSpacing(24, after: loginButton)
        
        view.addSubview(noContentStackView)
        loginButton.snp.makeConstraints { (make) in
            make.width.equalTo(scale * 120)
            make.height.equalTo(scale * 35)
        }
        registerButton.snp.makeConstraints { (make) in
            make.width.equalTo(scale * 120)
            make.height.equalTo(scale * 35)
        }
        noContentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

enum PopupType {
    case cart
    case favorites
}
