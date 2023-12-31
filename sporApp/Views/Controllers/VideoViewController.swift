//
//  VideoViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 22.06.2023.
//

import UIKit
import YouTubeiOSPlayerHelper

class VideoViewController: UIViewController, YTPlayerViewDelegate {
    @IBOutlet var playerView: YTPlayerView!
    @IBOutlet weak var neIseYararLabel: UILabel!
    @IBOutlet weak var aciklamaText: UITextView!
    
    var baslik: AltBaslik?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let gelen = baslik {
            if let id = gelen.video , let neIseYarar = gelen.ad ,let aciklama = gelen.aciklama {
                
                self.playerView.load(withVideoId: id)
                neIseYararLabel.text = "\(neIseYarar) Ne İşe Yarar?"
                aciklamaText.text = aciklama
            }
           
        }
    
    }
    @IBAction func geriTiklandi(_ sender: Any) {
        dismiss(animated: true)
    }
}
