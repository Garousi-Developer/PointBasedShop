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
        let interitemSpacing: CGFloat
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
        
        let itemWidth = CGFloat(Int(
            (width - horizontalInsets - interitemSpacings) / cellsPerRow
        ))
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
