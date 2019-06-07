import UIKit

class HomeTableController: TableController {
    var home: [Any] = []
    var dynamicHome: DynamicHome!
    
    var sliderPagerController: SliderPagerController!
    var categoriesCollectionController: CategoriesCollectionController!
    var closestOffersCollectionController: OffersCollectionController!
    var containersCollectionController: ContainersCollectionController!
    
    override func numberOfRows() -> Int {
        home = data
        dynamicHome = home [1] as? DynamicHome
        
        return 1 + dynamicHome.sections.count + 1
    }
    override func cell(forTableView tableView: TableView, atIndexPath indexPath: IndexPath) -> TableCell {
        if indexPath.row == 0 {
            let topStaticCell = tableView.dequeueReusableCell(withIdentifier: "topStatic", for: indexPath) as! TopStaticTableCell
            topStaticCell.tableController = self
            let sliderPagerView = topStaticCell.sliderPagerView!
            let categoriesCollectionView = topStaticCell.categoriesCollectionView!
            let closestOffersCollectionView = topStaticCell.closestOffersCollectionView!
            
            let topStaticHome = home[0] as! TopStaticHome
            
            setupYourPointsLabel(topStaticCell: topStaticCell, topStaticHome: topStaticHome)
            
            sliderPagerController = SliderPagerController(viewController: viewController, pagerView: sliderPagerView)
            sliderPagerController.index = 0
            sliderPagerController.sharedData = [topStaticHome.sliderAds]
            sliderPagerView.register(PagerCell.self, forCellWithReuseIdentifier: "reusable")
            sliderPagerView.dataSource = sliderPagerController
            sliderPagerView.delegate = sliderPagerController
            
            categoriesCollectionController = CategoriesCollectionController(
                viewController: viewController,
                collectionView: categoriesCollectionView
            )
            categoriesCollectionController.index = 0
            categoriesCollectionController.sharedData = [topStaticHome.categories]
            categoriesCollectionView.dataSource = categoriesCollectionController
            categoriesCollectionView.delegate = categoriesCollectionController
            
            closestOffersCollectionController = OffersCollectionController(
                viewController: viewController,
                collectionView: closestOffersCollectionView
            )
            closestOffersCollectionController.index = 0
            closestOffersCollectionController.sharedData = [topStaticHome.closestProducts]
            closestOffersCollectionView.dataSource = closestOffersCollectionController
            closestOffersCollectionView.delegate = closestOffersCollectionController
            
            topStaticCell.adImageView.image = topStaticHome.ad.picture
            
            return topStaticCell
        }
        else if indexPath.row < 1 + dynamicHome.sections.count {
            let dynamicCell = tableView.dequeueReusableCell(withIdentifier: "dynamic", for: indexPath) as! DynamicTableCell
            dynamicCell.tableController = self
            let containersCollectionView = dynamicCell.containersCollectionView!
            
            let section = dynamicHome.sections[indexPath.row - 1]
            let containersList = dynamicHome.sections.map { (category: Section) -> [Container] in
                return category.containers
            }
            
            dynamicCell.titleLabel.text = section.title
            
            containersCollectionController = ContainersCollectionController(viewController: viewController, collectionView: containersCollectionView)
            containersCollectionController.index = indexPath.row - 1
            containersCollectionController.sharedData = containersList
            containersCollectionView.dataSource = containersCollectionController
            containersCollectionView.delegate = containersCollectionController
            
            return dynamicCell
        }
        else {
            let bottomStaticCell = tableView.dequeueReusableCell(withIdentifier: "bottomStatic", for: indexPath) as! BottomStaticTableCell
            bottomStaticCell.tableController = self
            
            let bottomStaticHome = home[2] as! BottomStaticHome
            
            bottomStaticCell.adImageView.image = bottomStaticHome.ad.picture
            
            return bottomStaticCell
        }
    }
}

extension HomeTableController {
    private func setupYourPointsLabel(topStaticCell: TopStaticTableCell, topStaticHome: TopStaticHome) {
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(
            string: "\(texts(.yourPoints)) : "
        ))
        attributedText.append(NSAttributedString(
            string: "\(topStaticHome.userPoints)",
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
}
