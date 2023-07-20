//
//  MapsViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 20.07.2023.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapsViewModel {
    var istek = MKLocalSearch.Request()
    var alerts = AlertAction()
    var mapTip: MKMapType = .standard
    var mapsViewController: MapsViewController?
    
    
    func searchBarCalis(mapView: MKMapView,searchBar: UISearchBar,gelenKategori: String,locationManager: CLLocationManager) {
        if mapView.annotations.count > 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        mapsViewController?.view.endEditing(true)
        var deger = searchBar.text
        deger = gelenKategori
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
                        mapView.addAnnotation(pin)
                    }
                }
            } else {
                self.alerts.girisHata(mesaj: "Mekan yok.", viewControllers: self.mapsViewController)
                print("Mekan Yok")
            }
        }
        
    }
    
    func konumTiklandi(mapView: MKMapView,bolge: MKCoordinateRegion?){
        guard let _ = bolge else{return}
        mapView.setRegion(bolge!, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    func modeTiklandi(mapView: MKMapView){
        if mapTip == .standard {
            mapTip = .hybrid
            mapView.mapType = mapTip
        } else {
            mapTip = .standard
            mapView.mapType = mapTip
        }
    }
}
