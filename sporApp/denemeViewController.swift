//
//  NavigationViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 19.06.2023.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapsViewController: UIViewController, GMSMapViewDelegate, UITextFieldDelegate {
    var mapView: GMSMapView!
    var marker: GMSMarker!
    var autocompleteController: GMSAutocompleteViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.8688, longitude: 151.2195, zoom: 13.0)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.delegate = self
        view.addSubview(mapView)
        
        let inputTextField = UITextField(frame: CGRect(x: 16, y: 16, width: view.frame.width - 32, height: 40))
        inputTextField.placeholder = "Search"
        inputTextField.borderStyle = .roundedRect
        inputTextField.delegate = self
        view.addSubview(inputTextField)
        
        autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        present(autocompleteController, animated: true, completion: nil)
        return false
    }
}

extension MapsViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 11.0)
        mapView.camera = camera
        
        marker = GMSMarker()
        marker.position = place.coordinate
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.map = mapView
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Autocomplete error: \(error.localizedDescription)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}

    
  



