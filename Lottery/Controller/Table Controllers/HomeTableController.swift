import UIKit
//import MSPeekCollectionViewDelegateImplementation
import SnapKit

class HomeTableController: TableController {
    var homeArray: [Home] = []
    var home: Home!
    var citiesTitleDidRemove = false
    
    var sliderPagerController: SliderPagerController!
    var categoriesCollectionController: CategoriesCollectionController!
    var closestOffersCollectionController: ProductsCollectionController!
//    let closestOffersDelegate = MSPeekCollectionViewDelegateImplementation()
    var containersCollectionController: ContainersCollectionController!
    
    override func numberOfRows() -> Int {
        homeArray = data as! [Home]
        if !homeArray.isEmpty {
            home = homeArray[0]
        }
        
        return homeArray.isEmpty ? 0 : 5
    }
    override func cell(forTableView tableView: TableView, atIndexPath indexPath: IndexPath) -> TableCell {
        let sectionTitles = [texts(.cities), texts(.topShoppingCenters), texts(.topBrands)]
        let sectionContainers: [[Any]] = [home.cities, home.topShoppingCenters, home.topBrands]
        
        if indexPath.row == 0 {
            let topStaticCell = tableView.dequeueReusableCell(withIdentifier: "topStatic", for: indexPath) as! TopStaticTableCell
            topStaticCell.tableController = self
            let sliderPagerView = topStaticCell.sliderPagerView!
            let categoriesCollectionView = topStaticCell.categoriesCollectionView!
            
            setupYourPointsLabel(topStaticCell: topStaticCell, home: home)
            
            sliderPagerController = SliderPagerController(viewController: viewController, pagerView: sliderPagerView)
            sliderPagerController.data = home.sliderAds
            sliderPagerView.register(PagerCell.self, forCellWithReuseIdentifier: "reusable")
            sliderPagerView.dataSource = sliderPagerController
            sliderPagerView.delegate = sliderPagerController
            
            categoriesCollectionController = CategoriesCollectionController(
                viewController: viewController,
                collectionView: categoriesCollectionView
            )
            categoriesCollectionController.data = home.categories
            categoriesCollectionView.dataSource = categoriesCollectionController
            categoriesCollectionView.delegate = categoriesCollectionController
            
            topStaticCell.adImageView.downloadImageFrom(home.ads.first.pictureURL)
            
            return topStaticCell
        }
        else if indexPath.row < 4 {
            let dynamicCell = tableView.dequeueReusableCell(withIdentifier: "dynamic", for: indexPath) as! DynamicTableCell
            dynamicCell.tableController = self
            let containersCollectionView = dynamicCell.containersCollectionView!
            
            if indexPath.row == 1 && !citiesTitleDidRemove {
                citiesTitleDidRemove = true
                
                dynamicCell.titleLabel.removeFromSuperview()
                dynamicCell.containersCollectionView.snp.makeConstraints { (make) in
                    make.top.equalToSuperview()
                }
            }
            
            dynamicCell.titleLabel?.text = sectionTitles[indexPath.row - 1]
            
            containersCollectionController = ContainersCollectionController(viewController: viewController, collectionView: containersCollectionView)
            containersCollectionController.data = sectionContainers[indexPath.row - 1]
            containersCollectionView.dataSource = containersCollectionController
            containersCollectionView.delegate = containersCollectionController
            
//            containersCollectionView.contentOffset.x = containersCollectionView.contentSize.width - containersCollectionView.bounds.width
            
            return dynamicCell
        }
        else {
            let bottomStaticCell = tableView.dequeueReusableCell(withIdentifier: "bottomStatic", for: indexPath) as! BottomStaticTableCell
            bottomStaticCell.tableController = self
            
            bottomStaticCell.adImageView.downloadImageFrom(home.ads.second.pictureURL)
            
            return bottomStaticCell
        }
    }
}

extension HomeTableController {
    private func setupYourPointsLabel(topStaticCell: TopStaticTableCell, home: Home) {
        if UserDefaults.standard.string(forKey: "token") != nil {
            topStaticCell.yourPointsLabel.isHidden = false
            
            let attributedText = NSMutableAttributedString()
            attributedText.append(NSAttributedString(
                string: "\(texts(.yourPoints)) : "
            ))
            attributedText.append(NSAttributedString(
                string: "\(Int(home.userPoints).priceFormatted)",
                attributes: [
                    NSAttributedString.Key.font: fonts(.large),
                    NSAttributedString.Key.foregroundColor: colors(.green)
                ]
            ))
            attributedText.append(NSAttributedString(
                string: " "
            ))
            attributedText.append(NSAttributedString(
                string: "\(texts(.points))"
            ))
            topStaticCell.yourPointsLabel.attributedText = attributedText
        }
        else {
            topStaticCell.yourPointsLabel.isHidden = true
        }
    }
}
