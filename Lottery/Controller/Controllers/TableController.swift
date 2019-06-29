import UIKit

class TableController: SecondaryController {
    var tableView: TableView!
    var data: [Any] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var interactionAnimator: UIViewPropertyAnimator!
    var interactionAnimationDuration = durations(.interaction)
    var reverseInteractionAnimator: UIViewPropertyAnimator!
    var interactionAnimationIsReversible = false
    
    func animateInteraction(_ tableCell: TableCell) {
        interactionAnimator = UIViewPropertyAnimator(duration: interactionAnimationDuration, curve: .easeInOut) {
            if tableCell.backgroundColorHolder == nil {
                tableCell.backgroundColorHolder = tableCell.backgroundColor
            }
            
            tableCell.backgroundColor = colors(.highlightedPlaceholder)
        }
        
        interactionAnimator.startAnimation()
    }
    func animateInteractionReversely(_ tableCell: TableCell) {
        var reverseDelay: TimeInterval!
        if interactionAnimator.isRunning {
            reverseDelay = interactionAnimationDuration - TimeInterval(interactionAnimator.fractionComplete) * interactionAnimationDuration
        }
        else {
            reverseDelay = 0
        }
        
        reverseInteractionAnimator = UIViewPropertyAnimator(duration: interactionAnimationDuration, curve: .easeInOut) {
            tableCell.backgroundColor = tableCell.backgroundColorHolder
        }
        interactionAnimationIsReversible = true
        
        delay(reverseDelay) {
            self.reverseInteractionAnimator.startAnimation()
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
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let tableCell = tableView.cellForRow(at: indexPath) as! TableCell
        animateInteraction(tableCell)
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let tableCell = tableView.cellForRow(at: indexPath) as! TableCell
        animateInteractionReversely(tableCell)
    }
}

extension TableController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if interactionAnimationIsReversible {
            interactionAnimationIsReversible = false
            reverseInteractionAnimator.startAnimation()
        }
    }
}
