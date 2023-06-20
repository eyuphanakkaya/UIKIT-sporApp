//
//  NavigationViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 19.06.2023.
//

import UIKit
import MapKit
class NavigationViewController: UIViewController {
    
    class MapViewModel {
         
    }
    
    var sonKonum:CLLocation?
    var span:MKCoordinateSpan?
    var bolge:MKCoordinateRegion?
    var searchText = ""
    var mapType: MKMapType! = .standard
    var places = [Place]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapTip: UIButton!
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        for place in places {
            guard let coordinate = place.place.location?.coordinate else{return}
            print(place)
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = coordinate
            pointAnnotation.title = place.place.name ?? "İsim Yok"
            
            mapView.removeAnnotation(mapView.annotations as! MKAnnotation)
            mapView.addAnnotation(pointAnnotation)
        }

       
    }
    
    func updatingMap() {
        if mapType == .standard {
            mapType = .hybrid
            mapTip.setImage(UIImage(named: "network"), for: .normal)
        } else {
            mapType = .standard
            mapView.mapType = mapType
            mapTip.setImage( UIImage(named: "map"), for: .normal)
        }
    }
    
    func focusLocation(){
        guard let _ = bolge else{return}
        
        mapView.setRegion(bolge!, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }

    
    @IBAction func anaLokasyonTiklandi(_ sender: Any) {
        focusLocation()
    }
    
    @IBAction func mapTypeTiklandi(_ sender: Any) {
        if mapView.mapType == .standard {
            mapView.mapType = .hybrid
        } else {
            mapView.mapType = .standard
        }
    }
    func hata() {
        let hata = UIAlertController(title: "Hata", message: "İzin Verilmedi", preferredStyle: .alert)
        let okey = UIAlertAction(title: "Ayarlara Git", style: .cancel) { alertAction in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        hata.addAction(okey)
        present(hata, animated: true)
    }
    
    func selectPlace(place: Place,ara:String) {
        
        guard let coordinate = place.place.location?.coordinate else{return}
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "İsim Yok"
        
        mapView.removeAnnotation(mapView.annotations as! MKAnnotation)
        mapView.addAnnotation(pointAnnotation)
        
    }
    func arama(aramaYap:String){
        
        places.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = aramaYap
        
        MKLocalSearch(request: request).start { response, _ in
            guard let result = response else{return}
            
            self.places = result.mapItems.compactMap({ item -> Place? in
                return Place(place: item.placemark)
            })
        }
        if !places.isEmpty && aramaYap != "" {
            for x in places {
                print("Arama sonuc = \(x)")
            }
        }
        
    }
    
}
extension NavigationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        sonKonum = locations[locations.count-1]
        
        let konum = CLLocationCoordinate2DMake(sonKonum!.coordinate.latitude, sonKonum!.coordinate.longitude)
        
        span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        bolge = MKCoordinateRegion(center: konum, span: span!)
        
        mapView.setRegion(bolge!, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        

        mapView.showsUserLocation = true//location true olduğu için böyle gözüküyo
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied :
            hata()
        case .notDetermined :
            //
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse :
            manager.requestLocation()
        default:
            ()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}
extension NavigationViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            print(text)
            arama(aramaYap: text)
            for x in places {
                selectPlace(place: x , ara: searchBar.text!)
            }
            
        }
    }
}


