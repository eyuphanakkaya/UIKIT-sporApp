//
//  Place.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 19.06.2023.
//

import Foundation
import MapKit

struct Place:Identifiable {
    var id = UUID().uuidString
    var place: CLPlacemark
    
}
