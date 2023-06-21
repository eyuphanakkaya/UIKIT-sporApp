//
//  GooglePlacesManager.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 21.06.2023.
//

import Foundation
import GooglePlaces
import CoreLocation



struct Places {
    let name: String
    let identifier: String
}

final class GooglePlacesManager{
    
    static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init () {}
    
    enum PlacesError: Error {
        case failedToFind
        case failedToGetCoordinate
    }
    
    
    public func findPlaces(
        query: String
        ,complation: @escaping (Result<[Places], Error>) -> Void){
            let filter = GMSAutocompleteFilter()
            filter.type = .geocode
            client.findAutocompletePredictions(fromQuery: query, filter: filter, sessionToken: nil) { results, error in
                guard let results = results, error == nil else {
                    complation(.failure(PlacesError.failedToFind))
                    return
                }
                let places: [Places] = results.compactMap({
                    Places(name: $0.attributedFullText.string, identifier: $0.placeID)
                    
                })
                
                complation(.success(places))
            }
        
    }
    func resolveLocation (
        for place:Places,
        complation: @escaping (Result<CLLocationCoordinate2D, Error>) ->Void){
            client.fetchPlace(fromPlaceID: place.identifier, placeFields: .coordinate, sessionToken: nil) { googlePlace, error in
                guard let googlePlace = googlePlace ,error == nil else{
                    DispatchQueue.main.async {
                        complation(.failure(PlacesError.failedToGetCoordinate))
                    }
                    return
                }
                let coordinate = CLLocationCoordinate2D(latitude: googlePlace.coordinate.latitude, longitude: googlePlace.coordinate.longitude)
                
                complation(.success(coordinate ))
            }
    }
}

