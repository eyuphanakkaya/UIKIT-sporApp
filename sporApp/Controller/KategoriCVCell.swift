//
//  SporKategoriCollectionViewCell.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit


class KategoriCVCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var kategoriAdLabel: UILabel!
    
    
    func setUp(kate: Kategoriler) {
        imageView.image = UIImage(named: kate.resim!)
        kategoriAdLabel.text = kate.ad 
    }
    
}
