import UIKit

@IBDesignable
class CollectionView: UICollectionView {
    @IBInspectable var firstCellsPerPage: Int = 1
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}

extension CollectionView {
    private func setup() {
        semanticContentAttribute = .forceRightToLeft
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            switch flowLayout.scrollDirection {
            case .horizontal:
                alwaysBounceHorizontal = false
            case .vertical:
                // Align scroll indicator right.
                scrollIndicatorInsets = UIEdgeInsets(top: 0, left: bounds.width, bottom: 0, right: 0)
                
                alwaysBounceVertical = true
            @unknown default:
                break
            }
        }
    }
}
