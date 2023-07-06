//
//  AltBaslik.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import Foundation

struct AltBaslikCevap: Codable {
    var video: AltBaslik?
}

struct AltBaslik: Codable, Equatable {
    var id: String?
    var katid: String?
    var ad: String?
    var aciklama: String?
    var video: String?

    static func ==(lhs: AltBaslik, rhs: AltBaslik) -> Bool {
         return lhs.id == rhs.id
     }
}


