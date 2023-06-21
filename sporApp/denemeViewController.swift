import UIKit
import GoogleMaps
import GooglePlaces
import MapKit
import CoreLocation

class denemeViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var mapView: MKMapView!
    let searchVC = UISearchController(searchResultsController: ResultViewController())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
        searchVC.searchBar.backgroundColor = .secondarySystemBackground
       
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text ,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              let resultsVC = searchController.searchResultsController as? ResultViewController else{
                return
              }
        
        resultsVC.delegate = self
        
        GooglePlacesManager.shared.findPlaces(query: query) { result in
            switch result {
            case .success(let places):
                DispatchQueue.main.async {
                    resultsVC.update(with: places)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension denemeViewController: ResultViewControllerDelegate {
    func didTapPlace(with coordinate: CLLocationCoordinate2D) {
        searchVC.searchBar.resignFirstResponder()
        
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)

    }
    
    
}
