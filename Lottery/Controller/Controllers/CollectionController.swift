import UIKit

class CollectionController: SecondaryController {
    var collectionView: CollectionView!
    var data: [Any] = [] {
        didSet {
            if data.count < oldValue.count {
                let deletedItemIndexes = oldValue.indexOfDifferencesFrom(data)
                let deletedItemIndexPaths = deletedItemIndexes.map { (deletedItemIndex) -> IndexPath in
                    return IndexPath(item: deletedItemIndex, section: 0)
                }
                
                collectionView.deleteItems(at: deletedItemIndexPaths)
            }
            else if data.count == oldValue.count {
                collectionView.reloadData()
            }
            else {
                collectionView.reloadData()
            }
        }
    }
    
    var interactionAnimator: UIViewPropertyAnimator!
    var interactionAnimationDuration = durations(.interaction)
    var reverseInteractionAnimator: UIViewPropertyAnimator!
    var interactionAnimationIsReversible = false
    
    var layout: UICollectionViewFlowLayout!
    var itemWidth: CGFloat! {
        didSet {
            pagingThreshold = itemWidth / 2
        }
    }
    var interitemSpacing: CGFloat!
    
    var pagingThreshold: CGFloat!
    var currentOffset: CGFloat!
    var targetOffset: CGFloat!
    
    var initialHeight: CGFloat!
    
    func animateInteraction(_ collectionCell: CollectionCell) {
        interactionAnimator = UIViewPropertyAnimator(duration: interactionAnimationDuration, curve: .easeInOut) {
            if collectionCell.backgroundColorHolder == nil {
                collectionCell.backgroundColorHolder = collectionCell.backgroundColor
            }
            
            collectionCell.backgroundColor = colors(.highlightedPlaceholder)
        }
        
        interactionAnimator.startAnimation()
    }
    func animateInteractionReversely(_ collectionCell: CollectionCell) {
        var reverseDelay: TimeInterval!
        if interactionAnimator.isRunning {
            reverseDelay = interactionAnimationDuration - TimeInterval(interactionAnimator.fractionComplete) * interactionAnimationDuration
        }
        else {
            reverseDelay = 0
        }
        
        reverseInteractionAnimator = UIViewPropertyAnimator(duration: interactionAnimationDuration, curve: .easeInOut) {
            collectionCell.backgroundColor = collectionCell.backgroundColorHolder
        }
        interactionAnimationIsReversible = true
        
        delay(reverseDelay) {
            self.reverseInteractionAnimator.startAnimation()
        }
    }
    
    func itemHeight() -> CGFloat {
        return 0
    }
    func item(forCell cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        cell.collectionController = self
    }
    func willDisplay(cell: CollectionCell, atIndexPath indexPath: IndexPath) {
        
    }
    func itemDidSelect(atIndexPath indexPath: IndexPath) {
        
    }
    
    init(viewController: ViewController, collectionView: CollectionView) {
        super.init(viewController: viewController)
        
        let collectionViewLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let verticalSectionInsets = collectionViewLayout.sectionInset.top + collectionViewLayout.sectionInset.bottom
        collectionView.heightConstraint?.constant = itemHeight() + verticalSectionInsets + 1
        initialHeight = itemHeight() + verticalSectionInsets + 1
        
        switch collectionViewLayout.scrollDirection {
        case .horizontal:
            collectionView.decelerationRate = .fast
        case .vertical:
            break
        @unknown default:
            break
        }
        
        self.collectionView = collectionView
    }
}

extension CollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusable", for: indexPath) as! CollectionCell
        
        item(forCell: cell, atIndexPath: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplay(
            cell: cell as! CollectionCell,
            atIndexPath: indexPath
        )
    }
}
extension CollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        layout = collectionViewLayout as? UICollectionViewFlowLayout
        let cellsPerRow = CGFloat(self.collectionView.firstCellsPerPage)
        switch layout.scrollDirection {
        case .horizontal:
            interitemSpacing = layout.minimumLineSpacing
        case .vertical:
            interitemSpacing = layout.minimumInteritemSpacing
        @unknown default:
            return CGSize(width: 0, height: 0)
        }

        let width = collectionView.bounds.width
        let horizontalInsets = layout.sectionInset.left + layout.sectionInset.right
        let interitemSpacings: CGFloat
        if data.count == 1 {
            interitemSpacings = 0
        }
        else {
            interitemSpacings = cellsPerRow * interitemSpacing
        }

        itemWidth = CGFloat(Int(
            (width - horizontalInsets - interitemSpacings) / cellsPerRow
        ))
        if layout.scrollDirection == .horizontal {
            itemWidth = CGFloat(Int(
                (width - (3 + cellsPerRow) * interitemSpacing) / cellsPerRow
            ))
        }
        guard itemWidth > 0 else {
            fatalError("\"itemWidth\" must be positive.")
        }

        return CGSize(
            width: itemWidth,
            height: itemHeight()
        )
    }
}
extension CollectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemDidSelect(atIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let collectionCell = collectionView.cellForItem(at: indexPath) as! CollectionCell
//        animateInteraction(collectionCell)
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let collectionCell = collectionView.cellForItem(at: indexPath) as! CollectionCell
//        animateInteractionReversely(collectionCell)
    }
}

extension CollectionController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !data.isEmpty {
            if layout.scrollDirection == .horizontal {
                currentOffset = scrollView.contentOffset.x
            }
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        if !data.isEmpty {
            if layout.scrollDirection == .horizontal {
                let cellsPerRow = CGFloat(collectionView.firstCellsPerPage)
                
                targetOffset = targetContentOffset.pointee.x
                let scrollDistance = targetOffset - currentOffset
                let coefficent = Int(round(scrollDistance / (pagingThreshold * cellsPerRow))) * collectionView.firstCellsPerPage
                
                let currentItem = Int(round(currentOffset / itemWidth))
                let targetItem = currentItem + coefficent
                let targetItemOffset = CGFloat(targetItem) * (itemWidth + interitemSpacing)
                
                targetContentOffset.pointee.x = targetItemOffset
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if interactionAnimationIsReversible {
            interactionAnimationIsReversible = false
            reverseInteractionAnimator.startAnimation()
        }
    }
}
