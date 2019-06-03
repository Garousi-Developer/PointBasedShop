import UIKit

class ViewController: UIViewController {
    @IBInspectable var firstKeyboardHandler: Bool = false
    
    private var tapRecognizer: UITapGestureRecognizer!
    
    @objc func viewDidTap() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if firstKeyboardHandler {
            tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
            view.addGestureRecognizer(tapRecognizer)
        }
    }
}
