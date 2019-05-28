import UIKit

class ShapeLayer: CAShapeLayer {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init() {
        super.init()
        setup()
    }
    override init(layer: Any) {
        super.init(layer: layer)
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

extension ShapeLayer {
    private func setup() {
        
    }
}
