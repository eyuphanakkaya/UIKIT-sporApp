//
//  MapViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 21.06.2023.
//

import UIKit
import SwiftUI
import MapKit

class MapViewController: UIViewController {
    
    private let localSearchService = LocalSearchService()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        localSearchService.start
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchTextField)
        view.addSubview(mapView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mapView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        mapView.delegate = self
    }
    
    private func setupActions() {
        searchTextField.addTarget(self, action: #selector(searchTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func searchTextFieldDidChange(_ textField: UITextField) {
        guard let query = textField.text else { return }
        localSearchService.search(query: query)
    }
    
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localSearchService.landmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let landmark = localSearchService.landmarks[indexPath.row]
        cell.textLabel?.text = landmark.name
        cell.detailTextLabel?.text = landmark.title
        cell.textLabel?.textColor = localSearchService.landmark == landmark ? .purple : .black
        cell.detailTextLabel?.textColor = localSearchService.landmark == landmark ? .purple : .gray
        cell.backgroundColor = localSearchService.landmark == landmark ? UIColor.lightGray : UIColor.white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let landmark = localSearchService.landmarks[indexPath.row]
        localSearchService.landmark = landmark
        mapView.setRegion(MKCoordinateRegion.regionFromLandmark(landmark), animated: true)
        tableView.reloadData()
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PinAnnotationView")
        annotationView.pinTintColor = localSearchService.landmark == annotation as? Landmark ? .purple : .red
        annotationView.canShowCallout = false
        return annotationView
    }
    
}
