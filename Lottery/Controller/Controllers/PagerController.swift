import FSPagerView

class PagerController: SecondaryController {
    var pagerView: PagerView!
    var data: [Any] = [] {
        didSet {
            pagerView.reloadData()
        }
    }
    var pageControl: PageControl?
    
    func item(forCell cell: PagerCell, atIndex index: Int) {
        cell.pagerController = self
        cell.imageView!.clipsToBounds = true
        cell.imageView!.contentMode = .scaleAspectFill
    }
    
    init(viewController: ViewController, pagerView: PagerView, pageControl: PageControl? = nil) {
        super.init(viewController: viewController)
        
        self.pagerView = pagerView
        self.pageControl = pageControl
    }
}
extension PagerController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return data.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "reusable", at: index) as! PagerCell
        
        item(forCell: cell, atIndex: index)
        
        return cell
    }
}
extension PagerController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
        pageControl?.set(
            progress: pagerView.currentIndex,
            animated: true
        )
    }
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    func pagerView(_ pagerView: FSPagerView, shouldSelectItemAt index: Int) -> Bool {
        return false
    }
}
