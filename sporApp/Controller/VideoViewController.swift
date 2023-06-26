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
            if let id = gelen.ytId , let neIseYarar = gelen.ad ,let aciklama = gelen.aciklama {
                
                self.playerView.load(withVideoId: id)
                neIseYararLabel.text = "\(neIseYarar) Ne İşe Yarar?"
                aciklamaText.text = aciklama
            }
           
        }
        
       
        
        //playerView.load(withPlaylistId:"rT7DgCr-3pg", playerVars: ["playsinline" : 1] )
        
        // Do any additional setup after loading the view.
    }
    /*func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }*/
    

    @IBAction func geriTiklandi(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
