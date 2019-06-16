import UIKit

class SliderPagerController: PagerController {
    var ads: [NewAd] = []
    
    override func item(forCell cell: PagerCell, atIndex index: Int) {
        super.item(forCell: cell, atIndex: index)
        
        ads = data as! [NewAd]
        let ad = ads[index]
        
        cell.imageView!.downloadImageFrom(ad.pictureURL)
    }
}
