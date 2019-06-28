import UIKit

@IBDesignable
class CollectionView: UICollectionView {
    @IBInspectable var firstShadowStyle: String! {
        didSet {
            setShadowStyle(ShadowStyle(rawValue: firstShadowStyle)!)
        }
    }
    @IBInspectable var firstBorderStyle: String! {
        didSet {
            setBorderStyle(BorderStyle(rawValue: firstBorderStyle)!)
        }
    }
    @IBInspectable var firstMaskedCorners: String! {
        didSet {
            layer.maskedCorners = maskedCornerses(MaskedCorners(rawValue: firstMaskedCorners)!)
        }
    }
    @IBInspectable var firstCornerRadius: String! {
        didSet {
            setCornerRadius(CornerRadius(rawValue: firstCornerRadius)!)
        }
    }
    @IBInspectable var firstBackgroundColor: String! {
        didSet {
            backgroundColor = colors(Color(rawValue: firstBackgroundColor)!)
        }
    }
    @IBInspectable var firstTintColor: String! {
        didSet {
            tintColor = colors(Color(rawValue: firstTintColor)!)
        }
    }
    @IBInspectable var firstCellsPerPage: Int = 1
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
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
