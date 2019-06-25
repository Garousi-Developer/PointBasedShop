import UIKit

class RefreshControl: UIRefreshControl {
    var containerView: UIView! {
        didSet {
            containerView.addSubview(self)
        }
    }
    var requestHolder: RequestHolder!
    var requestHolders: [RequestHolder]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init() {
        super.init()
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
}

extension RefreshControl {
    private func setup() {
        tintColor = colors(.primary)
    }
}
