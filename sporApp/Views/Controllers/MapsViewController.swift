import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    var istek = MKLocalSearch.Request()
    var locationManager: CLLocationManager!
    var currentPlace: CLPlacemark!
    var mapTip: MKMapType = .standard
    var bolge: MKCoordinateRegion?
    var konum: CLLocationCoordinate2D?
    var span: MKCoordinateSpan?
    var gelenKategori:String?
    
    var mapViewModel = MapsViewModel()
    var alerts = AlertAction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapViewModel.mapsViewController = self
        searchBar.delegate = self
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        searchBar.isHidden = true
       
        
    }
    
    @IBAction func hemenBulTiklandi(_ sender: Any) {
        
        mapViewModel.searchBarCalis(mapView: mapView, searchBar: searchBar, gelenKategori: gelenKategori ?? "", locationManager: locationManager)
    }
    
    @IBAction func konumTiklandi(_ sender: Any) {
        mapViewModel.konumTiklandi(mapView: mapView,bolge: bolge)
    }
    
    @IBAction func modeTiklandi(_ sender: Any) {
        mapViewModel.modeTiklandi(mapView: mapView)
    }
    
    
}
extension MapsViewController: UISearchBarDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last?.coordinate else { return }
               
        konum = currentLocation
        span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
               bolge = MKCoordinateRegion(center: konum!, span: span!)
               
               mapView.setRegion(bolge!, animated: true)
               
               istek.region = mapView.region
               mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Konum alınamadı. Hata: \(error.localizedDescription)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PinAnnotation")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? MKPointAnnotation else {
            return
        }
        
        let requestLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(requestLocation) { placemarkDizi, hata in
            if let placemarks = placemarkDizi {
                if placemarks.count > 0 {
                    let yeniPlacemark = MKPlacemark(placemark: placemarks[0])
                    let item = MKMapItem(placemark: yeniPlacemark)
                    item.name = annotation.title ?? ""
                    
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    item.openInMaps(launchOptions: launchOptions)
                }
            }
        }
    }
}
