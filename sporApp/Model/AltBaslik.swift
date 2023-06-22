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
    var kategori_id: Int?
    var aciklama:String?
    var ytId:String?
    
    init() {
    }
    
    init(id: Int?, ad: String?, resim: String?, kategori_id: Int?,aciklama:String,ytId:String) {
        self.id = id
        self.ad = ad
        self.resim = resim
        self.kategori_id = kategori_id
        self.aciklama = aciklama
        self.ytId = ytId
    }
    
}

