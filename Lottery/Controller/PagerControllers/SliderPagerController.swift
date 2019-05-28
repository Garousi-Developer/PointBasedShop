import UIKit

class SliderPagerController: PagerController {
    var ads: [Ad] = []
    
    override func item(forCell cell: PagerCell, atIndex index: Int) {
        super.item(forCell: cell, atIndex: index)
        
        ads = sharedData[self.index] as! [Ad]
        let ad = ads[index]
        
        cell.imageView!.image = ad.picture
    }
}
