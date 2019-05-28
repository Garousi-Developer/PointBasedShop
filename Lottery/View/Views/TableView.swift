import UIKit

@IBDesignable
class TableView: UITableView {
    @IBInspectable var firstSimplifying: Bool = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

extension TableView {
    private func setup() {
        separatorStyle = .none
    }
}
