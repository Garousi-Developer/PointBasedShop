import UIKit

class BasicAnimation: CABasicAnimation {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init() {
        super.init()
        setup()
    }
}

extension BasicAnimation {
    private func setup() {
        timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        isRemovedOnCompletion = false
//        fillMode = .forwards
    }
}
