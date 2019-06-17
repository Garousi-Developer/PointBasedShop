import UIKit

@IBDesignable
class SearchBar: UISearchBar {
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
    @IBInspectable var firstCornerRadius: String = CornerRadius.medium.rawValue {
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
    
    var firstIsFirstLayout = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let textField = subviews[0].subviews[2] as! UITextField
        let textFieldBackgroundView = textField.subviews[0]
        
        if firstIsFirstLayout {
            firstIsFirstLayout = false
            
            textFieldBackgroundView.setCornerRadius(CornerRadius(rawValue: firstCornerRadius)!)
        }
    }
}

extension SearchBar {
    private func setup() {
        if subviews[0].subviews.count >= 3 && UIImage(named: "search") != nil {
            let textField = subviews[0].subviews[2] as! UITextField
            let searchImageView = textField.leftView as! UIImageView
            let textFieldBackgroundView = textField.subviews[0]
            
            enablesReturnKeyAutomatically = true
            searchBarStyle = .minimal
            backgroundColor = colors(.white)
            semanticContentAttribute = .forceRightToLeft
            setImage(#imageLiteral(resourceName: "search"), for: .search, state: .normal)
            placeholder = texts(.search)
            tintColor = colors(.darkAsset)
            
            textField.textAlignment = textAlignments(.right)
            textField.font = fonts(.medium)
            textField.minimumFontSize = fonts(.small).pointSize
            textField.textColor = colors(.darkAsset)
            textField.clearButtonMode = .never
            
            let searchTemplateImage = searchImageView.image!.withRenderingMode(.alwaysTemplate)
            searchImageView.frame.size.width = 18
            searchImageView.frame.size.height = 18
            searchImageView.tintColor = colors(.lightAsset)
            searchImageView.image = searchTemplateImage
            
            textFieldBackgroundView.clipsToBounds = true
            textFieldBackgroundView.backgroundColor = colors(.placeholder)
        }
    }
}
