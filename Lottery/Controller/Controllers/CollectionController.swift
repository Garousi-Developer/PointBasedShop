import UIKit

class CollectionController: SecondaryController {
    var collectionView: CollectionView!
    var data: [Any] = [] {
        didSet {
            if data.count < oldValue.count {
                let deletedItemIndex = oldValue.indexOfDifferenceFrom(data)!
                
                collectionView.deleteItems(at: [IndexPath(
                    item: deletedItemIndex,
                    section: 0
                )])
            }
            else if data.count == oldValue.count {
                collectionView.reloadData()
            }
            else {
                collectionView.reloadData()
            }
        }
    }
    
    var itemWidth: CGFloat! {
        didSet {
            pagingThreshold = itemWidth / 2
        }
    }
    var interitemSpacing: CGFloat!
    
    var pagingThreshold: CGFloat!
    var currentOffset: CGFloat!
    var targetOffset: CGFloat!
    
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
        
        switch collectionViewLayout.scrollDirection {
        case .horizontal:
            collectionView.heightConstraint?.constant = itemHeight() + verticalSectionInsets + 1
        case .vertical:
            collectionView.heightConstraint?.constant = itemHeight() + verticalSectionInsets + 1
        @unknown default:
            break
        }
        
        collectionView.decelerationRate = .fast
        
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
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
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
}

extension CollectionController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        currentOffset = scrollView.contentOffset.x
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let cellsPerRow = CGFloat(collectionView.firstCellsPerPage)
        
        targetOffset = targetContentOffset.pointee.x
        let scrollDistance = targetOffset - currentOffset
//        let coefficent: Int
//        if scrollDistance < -pagingThreshold {
//            coefficent = -1
//        }
//        else if scrollDistance > pagingThreshold {
//            coefficent = 1
//        }
//        else {
//            coefficent = 0
//        }
        let coefficent = Int(round(scrollDistance / (pagingThreshold * cellsPerRow))) * collectionView.firstCellsPerPage
        
        let currentItem = Int(round(currentOffset / itemWidth))
        let targetItem = currentItem + coefficent
        let targetItemOffset = CGFloat(targetItem) * (itemWidth + interitemSpacing)
        
        targetContentOffset.pointee.x = targetItemOffset
    }
}
