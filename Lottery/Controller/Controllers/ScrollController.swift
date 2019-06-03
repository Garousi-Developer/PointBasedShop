import UIKit

class ScrollController: SecondaryController {
    var scrollView: ScrollView!
    
    func didScroll() {
        
    }
    
    init(viewController: ViewController, scrollView: ScrollView) {
        super.init(viewController: viewController)
        
        self.scrollView = scrollView
    }
}
extension ScrollController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll()
    }
}
