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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        searchBar.isHidden = true
       
        //40.980826739943815, 28.717448396589425
        
        
    }
    
    @IBAction func hemenBulTiklandi(_ sender: Any) {
        searchBarCalis()
    }
    
    
    func searchBarCalis() {
        self.view.endEditing(true)
        var deger = searchBar.text
        deger = "Fitness"
        istek.naturalLanguageQuery = deger
        
        if let currentLocation = locationManager.location?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: currentLocation, span: span)
            
            mapView.setRegion(region, animated: true)
            istek.region = region
        }
        
        if mapView.annotations.count > 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        let arama = MKLocalSearch(request: istek)
        
        arama.start { response, error in
            if error != nil {
                print("Hata")
            } else if let mapItems = response?.mapItems, !mapItems.isEmpty {
                for mekan in mapItems {
                    if let ad = mekan.name, let tel = mekan.phoneNumber {
                        let pin = MKPointAnnotation()
                        pin.coordinate = mekan.placemark.coordinate
                        pin.title = ad
                        pin.subtitle = tel
                        self.mapView.addAnnotation(pin)
                    }
                }
            } else {
                print("Mekan Yok")
            }
        }
        
    }
    @IBAction func konumTiklandi(_ sender: Any) {
        guard let _ = bolge else{return}
        mapView.setRegion(bolge!, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    @IBAction func modeTiklandi(_ sender: Any) {
        if mapTip == .standard {
            mapTip = .hybrid
            mapView.mapType = mapTip
        } else {
            mapTip = .standard
            mapView.mapType = mapTip
        }
    }
    
    
}
extension MapsViewController: UISearchBarDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    }
    
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
