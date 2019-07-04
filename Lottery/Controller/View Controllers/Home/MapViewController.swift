import UIKit
import GoogleMaps

class MapViewController: ViewController {
    var container: Container!
    var cityDetails: CityDetails!
    var shoppingCenterDetails: ShoppingCenterDetails!
    var brandDetails: BrandDetails!
    var mapView: GMSMapView!
    var markers: [GMSMarker] = []
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = languageIsPersian ?
            "\(texts(.location).persian) \(container.name)" :
            "\(container.name) \(texts(.location).english)"
        
        let camera: GMSCameraPosition
        switch container.type {
        case .city:
            camera = GMSCameraPosition.camera(
                withLatitude: Double(cityDetails.latitude)!,
                longitude: Double(cityDetails.longitude)!,
                zoom: 15
            )
        case .shoppingCenter:
            camera = GMSCameraPosition.camera(
                withLatitude: Double(shoppingCenterDetails.latitude)!,
                longitude: Double(shoppingCenterDetails.longitude)!,
                zoom: 15
            )
        case .brand:
            camera = GMSCameraPosition.camera(withLatitude: 35.6892, longitude: 51.3890, zoom: 15)
        }
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        view.insertSubview(mapView, at: 0)
        
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        
        markers = []
        if container.type == .city {
            for shoppingCenter in cityDetails.topShoppingCenters {
                let markerImageView = ImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24 * 249 / 201))
                markerImageView.image = #imageLiteral(resourceName: "marker")
                
                let marker = GMSMarker(position: CLLocationCoordinate2D(
                    latitude: Double(shoppingCenter.latitude)!,
                    longitude: Double(shoppingCenter.longitude)!
                ))
                marker.iconView = markerImageView
                marker.title = languageIsPersian ? shoppingCenter.persianTitle : shoppingCenter.englishTitle
                marker.map = mapView
                markers.append(marker)
            }
        }
        showAllMarkers()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
}

extension MapViewController: GMSMapViewDelegate {
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        return true
    }
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: manager.location!.coordinate.latitude, longitude: manager.location!.coordinate.longitude)
        mapView.animate(toLocation: location)
    }
}

extension MapViewController {
    private func showAllMarkers() {
        guard let firstLocation = markers.first?.position else { return }
        var bounds = GMSCoordinateBounds(coordinate: firstLocation, coordinate: firstLocation)
        
        for marker in markers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: scale * 24))
    }
}
