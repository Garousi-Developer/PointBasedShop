import UIKit

class FilterScopesResponseController: ResponseController {
    override func didSucceed(response: Decodable?) {
        super.didSucceed(response: response)
        
        let castedViewController = viewController as! FilterViewController
        let filterScopes = response as! FilterScopes
        
        for selectedCategoryId in castedViewController.filterParameters.categories {
            filterScopes.categories.first { (category) in
                return category.id == selectedCategoryId
            }!.isSelected.toggle()
        }
        for selectedCityId in castedViewController.filterParameters.cities {
            filterScopes.cities.first { (city) in
                return city.id == selectedCityId
            }!.isSelected.toggle()
        }
        
        for category in filterScopes.categories {
            if !category.isSelected {
                castedViewController.allCategoriesSwitch.setOn(false, animated: false)
                break
            }
        }
        for city in filterScopes.cities {
            if !city.isSelected {
                castedViewController.allCitiesSwitch.setOn(false, animated: false)
                break
            }
        }
        
        castedViewController.categoriesCollectionController = SimpleCategoriesCollectionController(
            viewController: viewController,
            collectionView: castedViewController.categoriesCollectionView
        )
        castedViewController.categoriesCollectionController.data = filterScopes.categories
        castedViewController.categoriesCollectionView.dataSource = castedViewController.categoriesCollectionController
        castedViewController.categoriesCollectionView.delegate = castedViewController.categoriesCollectionController
        
        castedViewController.citiesCollectionController = SimpleCitiesCollectionController(
            viewController: viewController,
            collectionView: castedViewController.citiesCollectionView
        )
        castedViewController.citiesCollectionController.data = filterScopes.cities
        castedViewController.citiesCollectionView.dataSource = castedViewController.citiesCollectionController
        castedViewController.citiesCollectionView.delegate = castedViewController.citiesCollectionController
        
        setCategoriesAndCitiesHeights()
        
        castedViewController.setLoadingState(.successful)
        castedViewController.refreshControl.endRefreshing()
    }
    override func didFail(errorCode: URLError.Code?, statusCode: Int?, response: Decodable?) {
        super.didFail(errorCode: errorCode, statusCode: statusCode, response: response)
    }
}

extension FilterScopesResponseController {
    private func setCategoriesAndCitiesHeights() {
        let castedViewController = viewController as! FilterViewController
        let categoriesLayout = castedViewController.categoriesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfCategoryRows = CGFloat(round(Double(castedViewController.categoriesCollectionView.numberOfItems(inSection: 0)) / 2))
        let categoriesVerticalInsets = categoriesLayout.sectionInset.top + categoriesLayout.sectionInset.bottom
        let citiesLayout = castedViewController.citiesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfCityRows = CGFloat(round(Double(castedViewController.citiesCollectionView.numberOfItems(inSection: 0)) / 2))
        let citiesVerticalInsets = citiesLayout.sectionInset.top + citiesLayout.sectionInset.bottom
        
        castedViewController.categoriesCollectionView.heightConstraint.constant =
            numberOfCategoryRows * castedViewController.categoriesCollectionController.itemHeight() +
            (numberOfCategoryRows - 1) * categoriesLayout.minimumLineSpacing +
            categoriesVerticalInsets +
            1
        castedViewController.citiesCollectionView.heightConstraint.constant =
            numberOfCityRows * castedViewController.citiesCollectionController.itemHeight() +
            (numberOfCityRows - 1) * citiesLayout.minimumLineSpacing +
            citiesVerticalInsets +
            1
    }
}
