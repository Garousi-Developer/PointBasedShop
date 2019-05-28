import UIKit
import FSPagerView

@IBDesignable
class PagerView: FSPagerView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

extension PagerView {
    private func setup() {
        transform = CGAffineTransform(scaleX: -1, y: 1)
        
        automaticSlidingInterval = 5
        isInfinite = true
        removesInfiniteLoopForSingleItem = true
    }
}
