import UIKit

class TextLayer: CATextLayer {
    let uiFont = fonts(.medium)
    
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
    override func draw(in ctx: CGContext) {
        let verticalTranslation = bounds.height / 2 - uiFont.lineHeight / 2

        ctx.saveGState()
        ctx.translateBy(x: 0, y: verticalTranslation)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}

extension TextLayer {
    private func setup() {
        contentsScale = UIScreen.main.scale
        alignmentMode = .right
        font = uiFont.fontName as CFTypeRef
        fontSize = uiFont.pointSize
        foregroundColor = colors(.asset).cgColor
    }
}
