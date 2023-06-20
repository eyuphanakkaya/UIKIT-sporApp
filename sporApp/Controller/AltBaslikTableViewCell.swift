//
//  AltBaslikTableViewCell.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit

class AltBaslikTableViewCell: UITableViewCell {
    var altbaslik:AltBaslik?
    @IBOutlet weak var altBaslikAdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(alt: AltBaslik) {
        altBaslikAdLabel.text = alt.ad
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
