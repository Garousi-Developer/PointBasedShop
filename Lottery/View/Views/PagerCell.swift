import UIKit
import FSPagerView

@IBDesignable
class PagerCell: FSPagerViewCell {
    var pagerController: PagerController!
    
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

extension PagerCell {
    private func setup() {
        contentView.setShadowStyle(.none)
        contentView.transform = CGAffineTransform(scaleX: -1, y: 1)
        
        imageView!.contentMode = .scaleAspectFill
    }
}
