//
//  AltBaslik.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import Foundation

struct AltBaslik: Codable, Equatable {
    var id: Int?
    var ad: String?
    var resim: String?
    var kategori_id: Int?
    var aciklama: String?
    var ytId: String?

    static func ==(lhs: AltBaslik, rhs: AltBaslik) -> Bool {
         return lhs.id == rhs.id
     }
}


