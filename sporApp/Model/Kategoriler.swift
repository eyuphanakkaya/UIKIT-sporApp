//
//  Kategoriler.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import Foundation
struct KategoriCevap:Codable {
    var kategori:Kategoriler?
}
struct Kategoriler:Codable {
    var id: String?
    var ad: String?
    var resim: String?
}
