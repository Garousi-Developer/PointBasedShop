import CoreLocation
import UIKit

class HomeViewController: ViewController {
    @IBOutlet weak var tableView: TableView!
    
    var locationManager: CLLocationManager!
    var locationDidUpdate = false
    
    var home: Home!
    var closestOffers: [NewProduct]!
    var tableController: HomeTableController!
    var responseController: HomeResponseController!
    var closestOffersParameters: ClosestOffersParameters!
    var closestOffersResponseController: ClosestOffersResponseController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        tableController = HomeTableController(
            viewController: self,
            tableView: tableView
        )
        tableView.dataSource = tableController
        tableView.delegate = tableController
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()
        
        if locationDidUpdate {
            requestHome()
            requestClosestOffers(accordingToLocation: true)
        }
    }
}
extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .authorizedWhenInUse:
            if CLLocationManager.locationServicesEnabled() {
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
        default:
            requestHome()
            requestClosestOffers(accordingToLocation: false)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
        if !locationDidUpdate {
            locationDidUpdate = true
            requestHome()
            requestClosestOffers(accordingToLocation: true)
        }
    }
}

extension HomeViewController {
    func updateHome() {
        if home != nil && closestOffers != nil {
            tableController.closestOffers = closestOffers
            tableController.data = [home!]
            
            setLoadingState(.successful)
            refreshControl.endRefreshing()
            
            home = nil
            closestOffers = nil
        }
    }
    
    private func requestHome() {
        setLoadingState(.loading)
        tableController?.tableView.contentOffset.y = 0
        
        responseController = HomeResponseController(viewController: self)
        responseController.requestHolder = request(RequestHolder(
            endPointName: .home,
            didSucceed: responseController.didSucceed,
            didFail: responseController.didFail,
            blocking: false
        ))
    }
    private func requestClosestOffers(accordingToLocation: Bool) {
        if accordingToLocation {
//            let userCoordinate = locationManager.location!.coordinate
//            closestOffersParameters = ClosestOffersParameters(latitude: String(userCoordinate.latitude), longitude: String(userCoordinate.longitude))
            closestOffersParameters = ClosestOffersParameters(latitude: "35.6892", longitude: "51.3890")
        }
        else {
            closestOffersParameters = ClosestOffersParameters(latitude: "35.6892", longitude: "51.3890")
        }
        closestOffersResponseController = ClosestOffersResponseController(viewController: self)
        closestOffersResponseController.requestHolder = request(RequestHolder(
            endPointName: .closestOffers(parameters: closestOffersParameters),
            didSucceed: closestOffersResponseController.didSucceed,
            didFail: closestOffersResponseController.didFail,
            blocking: false
        ))
        
        refreshControl.containerView = tableView
        refreshControl.requestHolders = [responseController.requestHolder!, closestOffersResponseController.requestHolder!]
    }
}
