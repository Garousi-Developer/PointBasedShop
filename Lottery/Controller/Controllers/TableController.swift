import UIKit

class TableController: SecondaryController {
    var tableView: TableView!
    var data: [Any] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    func numberOfRows() -> Int {
        return 0
    }
    func row(forCell cell: TableCell, atIndexPath indexPath: IndexPath) {
        cell.tableController = self
    }
    func cell(forTableView tableView: TableView, atIndexPath indexPath: IndexPath) -> TableCell {
        return TableCell()
    }
    func rowDidSelect(atIndexPath indexPath: IndexPath) {
        
    }
    
    init(viewController: ViewController, tableView: TableView) {
        super.init(viewController: viewController)
        
        self.tableView = tableView
    }
}
extension TableController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tableView.firstSimplifying {
            return data.count
        }
        else {
            return numberOfRows()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.tableView.firstSimplifying {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reusable", for: indexPath) as! TableCell
            
            row(forCell: cell, atIndexPath: indexPath)
            
            return cell
        }
        else {
            return cell(
                forTableView: tableView as! TableView,
                atIndexPath: indexPath
            )
        }
    }
}
extension TableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowDidSelect(atIndexPath: indexPath)
    }
}
