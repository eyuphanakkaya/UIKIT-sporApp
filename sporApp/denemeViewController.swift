import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

class denemeViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    //@IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager: CLLocationManager!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    private var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Konum yöneticisini başlat
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        placesClient = GMSPlacesClient.shared()
        
        // Harita görünümünü oluştur
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        view.addSubview(mapView)
        
        placesSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Konum güncellemelerini başlat
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Konum güncellemelerini durdur
        locationManager.stopUpdatingLocation()
    }
    
    // Konum güncellendiğinde çalışacak metod
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        // Haritayı güncelle
        let camera = GMSCameraPosition.camera(withTarget: currentLocation.coordinate, zoom: 15.0)
        mapView.animate(to: camera)
        
        // Mevcut konumun işaretini ekle
        let marker = GMSMarker()
        marker.position = currentLocation.coordinate
        marker.title = "Mevcut Konum"
        marker.map = mapView
    }
    
    // Hata durumlarını işle
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Konum güncellenirken hata oluştu: \(error.localizedDescription)")
    }
    
    func placesSettings() {
        let placeFields: GMSPlaceField = [.name, .formattedAddress]
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                return
            }
            
            guard let place = placeLikelihoods?.first?.place else {
                strongSelf.nameLabel.text = "No current place"
                strongSelf.adressLabel.text = ""
                return
            }
            
            strongSelf.nameLabel.text = place.name
            strongSelf.adressLabel.text = place.formattedAddress
        }
    }
    
    @IBAction func buttonTiklandi(_ sender: Any) {
    }
}
