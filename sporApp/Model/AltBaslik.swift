//
//  AltBaslik.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import Foundation

class AltBaslik {
    var id: Int?
    var ad: String?
    var resim: String?
    var kategori_ad: String?
    
    init() {
    }
    
    init(id: Int?, ad: String?, resim: String?, kategori_ad: String?) {
        self.id = id
        self.ad = ad
        self.resim = resim
        self.kategori_ad = kategori_ad
    }
}

