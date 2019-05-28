import UIKit

@IBDesignable
class TableCell: UITableViewCell {
    var tableController: TableController!
    var indexPath: IndexPath {
        return tableController.tableView.indexPath(for: self)!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

extension TableCell {
    private func setup() {
        selectionStyle = .none
    }
}
