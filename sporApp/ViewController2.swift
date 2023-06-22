import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class ViewController2: UIViewController, GMSMapViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate, GMSAutocompleteViewControllerDelegate {
    var mapView: GMSMapView!
    var marker: GMSMarker?
    var autocompleteController: GMSAutocompleteViewController?
    var locationManager: CLLocationManager!
    var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 56))
        searchBar.placeholder = "Ara"
        searchBar.delegate = self
        view.addSubview(searchBar)

        if let topPadding = UIApplication.shared.windows.first?.safeAreaInsets.top {
            searchBar.frame.origin.y = topPadding
        }

        autocompleteController = GMSAutocompleteViewController()
        autocompleteController?.delegate = self

        locationManager = CLLocationManager()
        locationManager.delegate = self

        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            startUpdatingLocation()
        }

        let camera = GMSCameraPosition.camera(withLatitude: 40.993980202943774, longitude: 28.64869091407532, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: searchBar.frame.maxY, width: view.frame.width, height: view.frame.height - searchBar.frame.maxY), camera: camera)
        mapView.delegate = self
        view.addSubview(mapView)
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        mapView.isMyLocationEnabled = false
        mapView.settings.myLocationButton = false
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            startUpdatingLocation()
        } else {
            stopUpdatingLocation()
        }
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        present(autocompleteController!, animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 11.0)
        mapView.camera = camera

        marker?.map = nil
        marker = GMSMarker()
        marker?.position = place.coordinate
        marker?.title = place.name
        marker?.snippet = place.formattedAddress
        marker?.map = mapView

        dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Autocomplete error: \(error.localizedDescription)")
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
