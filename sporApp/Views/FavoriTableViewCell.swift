//
//  FavoriTableViewCell.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 26.06.2023.
//

import UIKit

class FavoriTableViewCell: UITableViewCell {

    var gelenDeger: AltBaslik? {
            didSet {
                updateUI()
            }
        }
    @IBOutlet weak var favIsimLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            favIsimLabel.text = nil // Hücre yeniden kullanıldığında içeriği sıfırla
        }
    private func updateUI() {
            if let gelen = gelenDeger {
                favIsimLabel.text = gelen.ad
            }
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
